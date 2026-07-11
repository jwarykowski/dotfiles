typeset -U path PATH
export PATH="$HOME/.local/bin:$PATH"
export VISUAL=nvim
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/config"
export EDITOR="$VISUAL"
export MYVIMRC="$HOME/.config/nvim/init.lua"
export TMPDIR="$HOME/.cache/tmp"
export XDG_CONFIG_HOME="$HOME/.config"
export DELTA_PAGER=cat
export SHEPHERD_CONFIG="$XDG_CONFIG_HOME/shepherd/config.toml"

