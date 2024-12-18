# zmodload zsh/zprof

export VISUAL=nvim
export EDITOR="$VISUAL"
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CONFIG="$HOME/.config/zsh"

TERM=xterm-256color
ZSH_THEME=""

plugins=(
  bgnotify
  command-not-found
  git
  git-extras
  yarn
  zsh-autosuggestions
  zsh-completions
  zsh-syntax-highlighting
  z
)

# oh-my-zsh
[[ -f "$ZSH/oh-my-zsh.sh" ]] \
    && source "$ZSH/oh-my-zsh.sh"

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
eval "$(/opt/homebrew/bin/brew shellenv)"

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

# gpg
# export GPG_TTY=$(tty)
# export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
# gpg-agent --options "$HOME/.config/.gnupg/gpg-agent-mac.conf"
# gpg-connect-agent updatestartuptty /bye > /dev/null

# fnm
export PATH="/Users/jwarykowski_1/Library/Application\ Support/fnm:$PATH"
eval "`fnm env`"

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

# puppeteer
export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
export PUPPETEER_EXECUTABLE_PATH=`which chromium`

# banner
clear
neofetch

# profile load times end
# zprof

# Created by `pipx` on 2024-11-19 11:20:24
export PATH="$PATH:/Users/jwarykowski_1/.local/bin"
