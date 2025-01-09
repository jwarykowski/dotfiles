# zmodload zsh/zprof

export VISUAL=nvim
export EDITOR="$VISUAL"
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CONFIG="$HOME/.config/zsh"

TERM=xterm-256color
ZSH_THEME=""

plugins=(
  command-not-found
  git
  git-extras
  yarn
  z
  zsh-autosuggestions
  zsh-completions
  zsh-syntax-highlighting
)

# oh-my-zsh
[[ -f "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

# options
setopt hist_ignore_space
setopt append_history
setopt extended_history

# aliases
[[ -f "$ZSH_CONFIG/alias.zsh" ]] \
    && source "$ZSH_CONFIG/alias.zsh"

# fzf
[[ -f "$ZSH_CONFIG/fzf.zsh" ]] \
    && source "$ZSH_CONFIG/fzf.zsh"

# functions
[[ -f "$ZSH_CONFIG/functions.zsh" ]] \
    && source "$ZSH_CONFIG/functions.zsh"

# bun completions
[ -s "/Users/jwarykowski/.bun/_bun" ] && source "/Users/jwarykowski/.bun/_bun"

# brew
[ -s "/opt/homebrew/bin/brew shellenv" ] && eval "$(/opt/homebrew/bin/brew shellenv)"

# android studio
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# deno
export PATH="$HOME/.deno/bin:$PATH"

# direnv
eval "$(direnv hook zsh)"

# fzf homebrew
source <(fzf --zsh)

# fnm
FNM_PATH="/home/jwarykowski/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/jwarykowski/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi

# java
export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"

# ruby
eval "$(rbenv init - zsh)"

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# nvim
export MYVIMRC="$HOME/.config/nvim/init.lua"

# prompt
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

# banner
fastfetch -l "none"

# profile load times end
# zprof
