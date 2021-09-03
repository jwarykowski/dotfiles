# Load relevant .profile for os
if [ "$(uname)" = "Darwin" ]; then
  source "$HOME/.profile.mac"
else
  source "$HOME/.profile.linux"
fi
