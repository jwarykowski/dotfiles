# moonlander layer on the right prompt when off the base layer (see kbd-layer);
# catches a toggled media layer that would otherwise be easy to forget
(( $+commands[kbd-layer] )) || return

_kbd_layer_precmd() {
  local layer
  layer=$(kbd-layer)
  RPROMPT=${layer:+"%F{yellow}⌨ $layer%f"}
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _kbd_layer_precmd
