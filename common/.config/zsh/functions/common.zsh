## directories
mkcd() {
  [[ $# -gt 1 ]] && return 1
  mkdir -p "$1" && cd "$1" || return 1
}

## documentation
fman() {
  man "$(apropos . | fzf | awk '{print $1}')"
}

## networking
myip() {
  curl -s ifconfig.me
}

## processes
fkill() {
  local pid
  pid=$(ps aux | fzf -m | awk '{print $2}')
  if [ -n "$pid" ]; then
    echo "$pid" | xargs kill -"${1:-9}"
  fi
}

cputop() {
  ps aux | sort -nrk 3 | head -n 20
}

memtop() {
  ps aux | sort -nrk 4 | head -n 20
}

## storage
diskusage() {
  df -h | grep -E 'Filesystem|/dev/'
}
