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

# projects
alias dev="cd ~/development"

# system
if [ "$(uname)" = "Darwin" ]; then
  alias rm="/bin/rm -irv"
else
  alias rm="/usr/bin/rm -irv"
fi

# yubikey switch
alias switch-yubikey="gpg-connect-agent 'scd serialno' 'learn --force' /bye"
