export VISUAL=nvim
export EDITOR="$VISUAL"

# android studio
if [ "$(uname)" = "Darwin" ]; then
  ANDROID_HOME="$HOME/Libary/Android/sdk"
else
  ANDROID_HOME="$HOME/shared/Android/Sdk"
fi

export ANDROID_HOME
export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools"

# brew and rbenv
if [ "$(uname)" = "Darwin" ]; then
  # brew package manager
  command -v brew > /dev/null 2>&1 || eval $(/opt/homebrew/bin/brew shellenv)

  # ruby rbenv package manager
  command -v rbenv > /dev/null 2>&1 || export PATH="$HOME/.rbenv/bin:$PATH" && eval "$(rbenv init -)"
fi

# cargo package manager
export PATH="$HOME/.cargo/bin:$PATH"

# direnv
eval "$(direnv hook zsh)"

# go package manager
export PATH="$HOME/go/bin:$PATH"

# gpg - to provide password
export GPG_TTY=$(tty)

# nvim
export MYVIMRC="$HOME/.config/nvim/init.vim"

# nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
  ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi

if [[ ! "$SSH_AUTH_SOCK" ]]; then
  eval "$(<"$XDG_RUNTIME_DIR/ssh-agent.env")"
fi

# volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
[ -s "$VOLTA_HOME/load.sh" ] && . "$VOLTA_HOME/load.sh"

# neofetch
neofetch
