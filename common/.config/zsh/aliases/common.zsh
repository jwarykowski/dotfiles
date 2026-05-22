# clear
alias c="clear"

# safe rm
alias rm="command rm -irv"

# config
alias zshconfig="nvim ~/.zshrc"

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# eza (ls replacement)
alias ls='eza --group-directories-first'
alias ll='eza -la --git --group-directories-first'
alias la='eza -a --group-directories-first'
alias lt='eza --tree --level=2 --group-directories-first'
alias llt='eza -la --tree --level=2 --git --group-directories-first'

# projects
alias dev="cd ~/development"
