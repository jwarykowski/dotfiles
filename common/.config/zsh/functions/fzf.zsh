# fzf widgets on the moonlander C-a / C-f thumbs, matching nvim's snacks
# grep / git-file pickers. needs `fzf --zsh` loaded first (see .zshrc)
(( $+widgets[fzf-file-widget] )) || return

# C-f: git files (incl. untracked) inside a repo, fzf's default walk outside
fzf-git-file-widget() {
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    local FZF_CTRL_T_COMMAND='git ls-files --cached --others --exclude-standard'
  fi
  zle fzf-file-widget
}
zle -N fzf-git-file-widget

# C-a: live ripgrep; enter opens the match in $EDITOR at that line
fzf-rg-widget() {
  local rg='rg --column --line-number --no-heading --color=always'
  local match
  match=$(fzf --ansi --disabled --delimiter : \
    --prompt 'rg> ' \
    --bind "change:reload:$rg -- {q} || true" \
    --preview 'bat --color=always --style=numbers --highlight-line {2} -- {1}' \
    --preview-window '+{2}-/2' </dev/tty)
  if [[ -z "$match" ]]; then
    zle reset-prompt
    return
  fi
  local file="${match%%:*}" rest="${match#*:}"
  BUFFER="${EDITOR:-nvim} +${rest%%:*} ${(q)file}"
  zle accept-line
}
zle -N fzf-rg-widget

for keymap in emacs viins vicmd; do
  bindkey -M $keymap '^F' fzf-git-file-widget
  bindkey -M $keymap '^A' fzf-rg-widget
done
unset keymap
