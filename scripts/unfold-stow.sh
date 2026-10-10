#!/usr/bin/env bash
# one-off migration from folded stow links (~/.config/herdr -> repo dir) to
# --no-folding (real dirs, per-file links). untracked runtime files that apps
# wrote into the repo through a folded link (herdr plugins/sessions, gh
# hosts.yml, shepherd boards) are moved back out to $HOME before restowing.
#
# usage: scripts/unfold-stow.sh [--apply]   (dry run without --apply)
set -euo pipefail

apply=false
case "${1:-}" in
  --apply) apply=true ;;
  "") ;;
  *) echo "usage: $0 [--apply]" >&2; exit 1 ;;
esac

log() { echo "==> $*"; }
run() {
  if [[ "$apply" == "true" ]]; then
    "$@"
  else
    echo "    would: $*"
  fi
}

dotfiles_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$dotfiles_dir"

case "$(uname -s)" in
  Darwin) platform="mac" ;;
  Linux) platform="linux" ;;
  *) echo "unsupported os" >&2; exit 1 ;;
esac

# herdr's socket and plugins live in ~/.config/herdr; moving them under a
# running server breaks it
if [[ "$apply" == "true" ]] && { [[ -n "${HERDR_ENV:-}" ]] || pgrep -u "$USER" -x herdr >/dev/null 2>&1 ||
  pgrep -u "$USER" -f 'herdr server' >/dev/null 2>&1; }; then
  echo "herdr is running; run 'herdr server stop' and rerun from a plain terminal" >&2
  exit 1
fi

# folded links: symlinks in $HOME pointing at a directory inside a stow package
folded=()
while IFS= read -r -d '' link; do
  [[ -d "$link" ]] || continue # link to a dir (bsd find has no -xtype)
  target="$(readlink -f "$link")"
  case "$target" in
    "$dotfiles_dir/common/"* | "$dotfiles_dir/$platform/"*) folded+=("$link") ;;
  esac
done < <(find "$HOME" -maxdepth 3 -type l -print0 2>/dev/null)

if ((${#folded[@]} == 0)); then
  log "no folded links found"
else
  for link in "${folded[@]}"; do
    target="$(readlink -f "$link")"
    rel="${target#"$dotfiles_dir"/}"
    log "unfolding ${link/#$HOME/\~} ($rel)"
    run rm "$link"
    run mkdir -p "$link"

    # untracked + ignored entries (whole dirs where possible) go back to $HOME
    while IFS= read -r -d '' path; do
      path="${path%/}"
      dest="$link/${path#"$rel"/}"
      echo "    move $path -> ${dest/#$HOME/\~}"
      run mkdir -p "$(dirname "$dest")"
      run mv "$path" "$dest"
    done < <(git ls-files -z --others --directory -- "$rel")
  done
fi

log "restowing with --no-folding"
if [[ "$apply" == "true" ]]; then
  ./install.sh
else
  # a stow preview here would report the not-yet-moved runtime files as conflicts
  echo "    would: ./install.sh"
fi

# the old excludes file, superseded by ~/.config/git/ignore
if [[ -f "$HOME/.gitignore" && ! -L "$HOME/.gitignore" ]]; then
  log "removing unused ~/.gitignore (contents now in ~/.config/git/ignore)"
  run rm "$HOME/.gitignore"
fi

if [[ "$apply" == "true" ]]; then
  leftover="$(git status --short --ignored -- common "$platform")"
  if [[ -n "$leftover" ]]; then
    log "untracked files still in the repo:"
    echo "$leftover"
  fi
  log "done; start herdr again"
else
  log "dry run only; rerun with --apply"
fi
