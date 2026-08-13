## directories
mkcd() {
  [[ $# -gt 1 ]] && return 1
  mkdir -p "$1" && cd "$1" || return 1
}

## files
tarcompress() {
  if [[ $# -lt 2 ]]; then
    echo "usage: tarcompress <directory> <archive.tar.gz>"
    return 1
  fi
  local src="$1"
  local dest="$2"
  local size
  # -sk rather than -sb: bsd du has no -b
  size=$(($(du -sk "$src" | awk '{print $1}') * 1024))
  tar -cf - "$src" | pv -s "$size" | gzip > "$dest"
}

taruncompress() {
  if [[ $# -lt 1 ]]; then
    echo "usage: taruncompress <archive.tar.gz> [destination]"
    return 1
  fi
  local archive="$1"
  local dest="${2:-.}"
  local size
  size=$(($(du -sk "$archive" | awk '{print $1}') * 1024))
  pv -s "$size" "$archive" | tar -xzf - -C "$dest"
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

## utils
uuid() {
  uuidgen
}
