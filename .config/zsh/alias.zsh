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
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias dfa="dotfiles add"
alias dfs="dotfiles status"

# projects
alias dev="cd ~/work"
alias li="cd ~/work/lighthouse"

# system
if [ "$(uname)" = "Darwin" ]; then
  alias rm="/bin/rm -irv"
else
  alias rm="/usr/bin/rm -irv"
fi
