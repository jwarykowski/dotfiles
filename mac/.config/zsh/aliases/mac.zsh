# gpg
# https://steinbaugh.com/posts/gnupg.html
alias restart-gpg="gpgconf --kill all"
alias restart-gpg-connect-agent="gpg-connect-agent reloadagent /bye"
alias restart-gpg-agent-daemon="gpgconf --kill gpg-agent && gpgconf --launch gpg-agent"
