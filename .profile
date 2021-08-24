# Load relevant .profile for os
if [ "$(uname)" = "Darwin" ]; then
  source "$HOME/.profile.mac"
else
  source "$HOME/.profile.linux"
fi
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
