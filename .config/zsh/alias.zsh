# parents
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'
alias ........='cd ../../../../../../..'

# clear
alias c="clear"

# config
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias zshconfig="nvim ~/.zshrc"

# dotfiles
alias cfg="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# gpg
# https://steinbaugh.com/posts/gnupg.html
alias restart-gpg="gpgconf --kill all"
alias restart-gpg-connect-agent="gpg-connect-agent reloadagent /bye"
alias restart-ggp-agent-daemon="pkill -9 gpg-agent && source <(gpg-agent --daemon)"

# projects
alias dev="cd ~/development"

# system bin
if [ "$(uname)" = "Darwin" ]; then
  alias rm="/bin/rm -irv"
else
  alias rm="/usr/bin/rm -irv"
fi

# yubikey switch
alias switch-yubikey="gpg-connect-agent 'scd serialno' 'learn --force' /bye"
