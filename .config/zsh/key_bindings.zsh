# ctrl+arrows
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word
bindkey "\e[5C" forward-word
bindkey "\e[5D" backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word

# alt+arrows
bindkey "\e[1;3C" vi-forward-blank-word
bindkey "\e[1;3D" vi-backward-blank-word
bindkey "\e[3C" vi-forward-blank-word
bindkey "\e[3D" vi-backward-blank-word
bindkey "\e\e[C" vi-forward-blank-word
bindkey "\e\e[D" vi-backward-blank-word

# ctrl+delete
bindkey "\e[3;5~" kill-word
bindkey "\e[3;3~" kill-word

# ctrl+backspace
bindkey '^H' backward-kill-word

# ctrl+shift+delete
bindkey "\e[3;6~" kill-line
