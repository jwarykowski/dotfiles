source $HOME/.config/zsh/utils.zsh

[[ -r ~/Repos/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/Repos/znap

source ~/Repos/znap/znap.zsh  # start znap

## configuration
znap prompt sindresorhus/pure # theme

## plugins
ZSH_AUTOSUGGEST_STRATEGY=( history )
znap source zsh-users/zsh-autosuggestions

ZSH_HIGHLIGHT_HIGHLIGHTERS=( main brackets )
znap source zsh-users/zsh-syntax-highlighting

if command -v fzf >/dev/null 2>&1; then
  znap source junegunn/fzf shell/completion.zsh
  znap source junegunn/fzf shell/key-bindings.zsh
fi

znap clone https://github.com/agkozak/zsh-z.git
znap source zsh-z

# common aliases/utilities
source_recursive "$HOME/.config/zsh/aliases" "zsh"
source_recursive "$HOME/.config/zsh/functions" "zsh"

# local additions/overrides
if [[ -f "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi
