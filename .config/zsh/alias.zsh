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
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# git
alias cgb="git fetch -p && for branch in $(git for-each-ref --format '%(refname) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}'); do git branch -D $branch; done"

# projects
alias dev="cd ~/development"
alias li="cd ~/development/lighthouse"

# system
alias rm="trash"

# vimwiki
alias studying="nvim vimwiki/Studying.wiki"
alias todos="nvim vimwiki/Todos.wiki"
alias wiki="nvim vimwiki/index.wiki"
