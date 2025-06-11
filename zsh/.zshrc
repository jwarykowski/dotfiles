# zmodload zsh/zprof

export VISUAL=nvim
export EDITOR="$VISUAL"
export XDG_CONFIG_HOME="$HOME/.config"
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

# dotnet
export DOTNET_ROOT="$HOME/.dotnet"
export PATH="$HOME/.dotnet:$PATH"
export PATH="$PATH:/Users/jwarykowski_1/.dotnet/tools"

# fzf homebrew
source <(fzf --zsh)

# fnm
FNM_PATH="/Users/jwarykowski_1/Library/Application Support/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/Users/jwarykowski_1/Library/Application Support/fnm:$PATH"
  eval "`fnm env`"
fi

# java - react native
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home

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
