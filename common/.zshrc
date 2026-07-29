source $HOME/.config/zsh/utils.zsh

# history
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY

export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=100000

# options
setopt AUTO_CD
setopt CORRECT

[[ -r ~/Repos/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/Repos/znap

source ~/Repos/znap/znap.zsh  # start znap

## configuration
# load pure without znap's instant-prompt (avoids the double-render on launch)
znap source mafredri/zsh-async
znap source sindresorhus/pure
fpath+=( ${ZNAP_REPOS:-~/Repos}/sindresorhus/pure )   # ensure promptinit can find prompt_pure_setup
autoload -Uz promptinit
promptinit
prompt pure

## plugins
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

znap source agkozak/zsh-z

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

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"
