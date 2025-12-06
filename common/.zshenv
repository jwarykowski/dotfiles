export EDITOR="$VISUAL"
export MYVIMRC="$HOME/.config/nvim/init.lua"
export TMPDIR="$HOME/.cache/tmp"
export VISUAL=nvim
export XDG_CONFIG_HOME="$HOME/.config"

# history
setopt EXTENDED_HISTORY          # write the history file in the ':start:elapsed;command' format.
setopt HIST_EXPIRE_DUPS_FIRST    # expire a duplicate event first when trimming history.
setopt HIST_FIND_NO_DUPS         # do not display a previously found event.
setopt HIST_IGNORE_ALL_DUPS      # delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS          # do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE         # do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # do not write a duplicate event to the history file.
setopt SHARE_HISTORY             # share history between all sessions.

export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=$HISTSIZE
