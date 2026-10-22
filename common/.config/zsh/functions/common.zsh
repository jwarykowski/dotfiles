## directories
mkcd() {
  [[ $# -gt 1 ]] && return 1
  mkdir -p "$1" && cd "$1" || return 1
}

## files
tarcompress() {
  if [[ $# -lt 2 ]]; then
    echo "usage: tarcompress <directory> <archive.tar.gz>"
    return 1
  fi
  local src="$1"
  local dest="$2"
  local size
  # -sk rather than -sb: bsd du has no -b
  size=$(($(du -sk "$src" | awk '{print $1}') * 1024))
  tar -cf - "$src" | pv -s "$size" | gzip > "$dest"
}

taruncompress() {
  if [[ $# -lt 1 ]]; then
    echo "usage: taruncompress <archive.tar.gz> [destination]"
    return 1
  fi
  local archive="$1"
  local dest="${2:-.}"
  local size
  size=$(($(du -sk "$archive" | awk '{print $1}') * 1024))
  pv -s "$size" "$archive" | tar -xzf - -C "$dest"
}

## documentation
fman() {
  man "$(apropos . | fzf | awk '{print $1}')"
}

## git worktrees (beside the repo as <repo>--<branch>)
gwa() {
  if [[ -z "$1" ]]; then
    echo "usage: gwa <branch>"
    return 1
  fi
  local root
  root=$(git rev-parse --show-toplevel) || return 1
  local dir="${root}--${1//\//-}"
  git worktree add -b "$1" "$dir" && cd "$dir"
}

gwd() {
  local root main branch
  root=$(git rev-parse --show-toplevel) || return 1
  main=$(git worktree list --porcelain | awk 'NR == 1 { print $2 }')
  branch=$(git branch --show-current)
  if [[ "$root" == "$main" ]]; then
    echo "gwd: not in a linked worktree"
    return 1
  fi
  read -q "?remove worktree $root and branch $branch? [y/N] " || { echo; return 1; }
  echo
  cd "$main" && git worktree remove "$root" && git branch -D "$branch"
}

## networking
myip() {
  curl -s ifconfig.me
}

# reconnect dropped interactive sessions; ctrl-c stops the retry loop
ssh() {
  if [[ $# -ne 1 || ! -t 0 ]]; then
    command ssh "$@"
    return
  fi
  local rc start
  while true; do
    start=$SECONDS
    command ssh "$1"
    rc=$?
    # leave the alt screen, show the cursor, stop mouse reporting
    printf '\e[?1049l\e[?25h\e[?1000l\e[?1002l\e[?1006l'
    # 255 is ssh's own failure; a quick one is auth or a bad host, not a drop
    (( rc == 255 && SECONDS - start > 10 )) || return $rc
    echo "connection to $1 lost, reconnecting..."
    sleep 2
  done
}

# fip <host> <port...>: forward remote ports to localhost
fip() {
  if [[ $# -lt 2 ]]; then
    echo "usage: fip <host> <port...>"
    return 1
  fi
  local host="$1" port
  shift
  for port in "$@"; do
    command ssh -f -N -L "$port:localhost:$port" "$host" && echo "forwarding localhost:$port -> $host:$port"
  done
}

lip() {
  pgrep -fl 'ssh -f -N -L' || echo "no forwards"
}

dip() {
  pkill -f 'ssh -f -N -L' && echo "forwards stopped"
}

## sync
# rsw <src> <dest>: rsync every 2s in the background
# shortcut: polls rather than watching for changes, use fswatch/inotifywait if it gets heavy
rsw() {
  if [[ $# -ne 2 ]]; then
    echo "usage: rsw <src> <dest>"
    return 1
  fi
  local dir="${XDG_CACHE_HOME:-$HOME/.cache}/rsw"
  mkdir -p "$dir"
  nohup sh -c 'while rsync -a "$1" "$2"; do sleep 2; done' rsw "$1" "$2" >/dev/null 2>&1 &
  echo "$1 -> $2" > "$dir/$!"
  echo "watching $1 -> $2 (pid $!)"
}

lsw() {
  local dir="${XDG_CACHE_HOME:-$HOME/.cache}/rsw" file
  for file in "$dir"/*(N); do
    if kill -0 "${file:t}" 2>/dev/null; then
      echo "${file:t}: $(<"$file")"
    else
      command rm -f "$file"
    fi
  done
}

dsw() {
  local dir="${XDG_CACHE_HOME:-$HOME/.cache}/rsw" file
  for file in "$dir"/*(N); do
    kill "${file:t}" 2>/dev/null
    command rm -f "$file"
  done
}

## processes
fkill() {
  local pid
  pid=$(ps aux | fzf -m | awk '{print $2}')
  if [ -n "$pid" ]; then
    echo "$pid" | xargs kill -"${1:-TERM}"
  fi
}

cputop() {
  ps aux | sort -nrk 3 | head -n 20
}

memtop() {
  ps aux | sort -nrk 4 | head -n 20
}

## storage
diskusage() {
  df -h | grep -E 'Filesystem|/dev/'
}

## utils
uuid() {
  uuidgen
}
