# herdr dev layouts; a split's --ratio is the share the original pane keeps
(( $+commands[herdr] && $+commands[jq] )) || return

_hd_split() { # <pane> <right|down> <ratio> [cwd]
  local id
  id=$(herdr pane split "$1" --direction "$2" --ratio "$3" --cwd "${4:-$PWD}" --no-focus |
    jq -r '.result.pane.pane_id // empty')
  [[ -n "$id" ]] && echo "$id"
}

_hd_require() {
  [[ -n "$HERDR_PANE_ID" ]] && return
  echo "not inside a herdr pane"
  return 1
}

# editor left, agent top right, shell bottom right
_hd_dev() { # <pane> <dir> <agent>
  local agent
  agent=$(_hd_split "$1" right 0.6 "$2") || return 1
  _hd_split "$agent" down 0.7 "$2" >/dev/null
  herdr pane run "$agent" "$3" >/dev/null
}

hdl() {
  _hd_require || return 1
  _hd_dev "$HERDR_PANE_ID" "$PWD" "${1:-claude}" && "${EDITOR:-nvim}"
}

# hdl layout in a new tab per subdirectory
hdlm() {
  _hd_require || return 1
  local dir pane
  for dir in "$PWD"/*(/); do
    pane=$(herdr tab create --cwd "$dir" --label "${dir:t}" --no-focus |
      jq -r '.result.root_pane.pane_id // empty')
    [[ -n "$pane" ]] || continue
    _hd_dev "$pane" "$dir" "${1:-claude}" &&
      herdr pane run "$pane" "${EDITOR:-nvim}" >/dev/null
  done
}

# editor | agent over shell | lazygit
hds() {
  _hd_require || return 1
  local right
  right=$(_hd_split "$HERDR_PANE_ID" right 0.5) || return 1
  herdr pane run "$(_hd_split "$right" down 0.5)" lazygit >/dev/null
  _hd_split "$HERDR_PANE_ID" down 0.5 >/dev/null
  herdr pane run "$right" "${1:-claude}" >/dev/null
  "${EDITOR:-nvim}"
}

# grid of <count> panes all running <command>
hsl() {
  if [[ $# -lt 2 || "$1" != <1-> ]]; then
    echo "usage: hsl <count> <command>"
    return 1
  fi
  _hd_require || return 1
  local count=$1 cmd="${*:2}" cols=1 col row rows pane
  while (( cols * cols < count )); do (( cols++ )); done
  local -a columns=("$HERDR_PANE_ID") panes=()
  for (( col = 2; col <= cols; col++ )); do
    columns+=("$(_hd_split "${columns[-1]}" right $(( 1.0 / (cols - col + 2) )))")
  done
  for (( col = 1; col <= cols; col++ )); do
    rows=$(( count / cols + (col <= count % cols) ))
    pane=${columns[col]}
    panes+=("$pane")
    for (( row = 2; row <= rows; row++ )); do
      pane=$(_hd_split "$pane" down $(( 1.0 / (rows - row + 2) )))
      panes+=("$pane")
    done
  done
  for pane in "${panes[@]:1}"; do
    herdr pane run "$pane" "$cmd" >/dev/null
  done
  eval "$cmd"
}
