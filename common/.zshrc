source $HOME/.config/zsh/utils.zsh

# history
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY

export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

# options
setopt AUTO_CD
setopt CORRECT

[[ -r ~/Repos/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/Repos/znap

# clone failed (offline first run): stub znap so the rest still loads
if [[ -r ~/Repos/znap/znap.zsh ]]; then
  source ~/Repos/znap/znap.zsh
else
  echo "znap unavailable: plugins skipped" >&2
  znap() { : }
fi

## configuration
# load pure without znap's instant-prompt (avoids the double-render on launch)
znap source mafredri/zsh-async
znap source sindresorhus/pure

## plugins
# fzf picker for tab completion; must load before plugins that wrap widgets
znap source Aloxaf/fzf-tab
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

ZSH_AUTOSUGGEST_STRATEGY=( history completion )
znap source zsh-users/zsh-autosuggestions

ZSH_HIGHLIGHT_HIGHLIGHTERS=( main brackets cursor )
znap source zsh-users/zsh-syntax-highlighting

# must load after syntax-highlighting
znap source zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

znap source zsh-users/zsh-completions

# herdr subcommand completion, regenerated only when the binary changes
if (( $+commands[herdr] )); then
  _herdr_comp=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/completions/_herdr
  if [[ ! -s $_herdr_comp || $commands[herdr] -nt $_herdr_comp ]]; then
    mkdir -p ${_herdr_comp:h} && herdr completion zsh >| $_herdr_comp
  fi
  fpath=(${_herdr_comp:h} $fpath)
  unset _herdr_comp
fi

if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi

# common aliases/utilities
source_dir "$HOME/.config/zsh/aliases" "zsh"
source_dir "$HOME/.config/zsh/functions" "zsh"

# local additions/overrides
if [[ -f "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi

# macOS path_helper pushes ~/.local/bin behind system dirs in login shells
path=("$HOME/.local/bin" $path)

# tool hooks (after .zshrc.local so brew's PATH is in place on mac)
[[ -d "$HOME/.cargo/bin" ]] && path=("$HOME/.cargo/bin" $path)
for d in "$HOME/Library/Application Support/bob/nvim-bin" "$HOME/.local/share/bob/nvim-bin"; do
  [[ -d "$d" ]] && path=("$d" $path)
done
command -v direnv >/dev/null && znap eval direnv 'direnv hook zsh'
# not znap-cached: activate bakes the current PATH into its output
command -v mise >/dev/null && eval "$(mise activate zsh)"
command -v zoxide >/dev/null && znap eval zoxide 'zoxide init zsh'

# bun globals (bun itself comes from mise); appended so mise's bun wins
export BUN_INSTALL="$HOME/.bun"
[[ -d "$BUN_INSTALL/bin" ]] && path+=("$BUN_INSTALL/bin")
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"
