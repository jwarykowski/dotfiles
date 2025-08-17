# gpg
# https://steinbaugh.com/posts/gnupg.html
alias restart-gpg="gpgconf --kill all"
alias restart-gpg-connect-agent="gpg-connect-agent reloadagent /bye"
alias restart-ggp-agent-daemon="pkill -9 gpg-agent && source <(gpg-agent --daemon)"

# safe rm
alias rm="/bin/rm -irv"
