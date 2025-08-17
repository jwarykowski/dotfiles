## directories
# mkdir + cd
mkcd() {
  [[ $# -gt 1 ]] && return 1
  mkdir -p "$1" && cd "$1" || return 1
}

## documentation
# man search with fzf
fman() {
  man "$(apropos . | fzf | awk '{print $1}')"
}

## files
# compress directory as tar.gz with progress
tarcompress() {
  if [[ $# -lt 2 ]]; then
    echo "usage: tarcompress <directory> <archive.tar.gz>"
    return 1
  fi
  local src="$1"
  local dest="$2"

  # get total size in bytes (mac: du -sk gives KB)
  local size
  size=$(du -sk "$src" | awk '{print $1}')
  size=$((size * 1024))

  # create archive with progress
  tar -cf - "$src" | pv -s "$size" | gzip > "$dest"
}

# uncompress tar.gz with progress
taruncompress() {
  if [[ $# -lt 1 ]]; then
    echo "usage: taruncompress <archive.tar.gz> [destination]"
    return 1
  fi
  local archive="$1"
  local dest="${2:-.}"

  # get total size (compressed size in bytes)
  local size
  size=$(du -sk "$archive" | awk '{print $1}')
  size=$((size * 1024))

  # extract with progress
  pv -s "$size" "$archive" | tar -xzf - -C "$dest"
}

## networking
# my public ip
myip() {
  curl -s ifconfig.me
}

## processes
# kill process interactively
fkill() {
  local pid
  pid=$(ps aux | fzf -m | awk '{print $2}')
  if [ -n "$pid" ]; then
    echo "$pid" | xargs kill -"${1:-9}"
  fi
}

# cpu usage (top 20)
cputop() {
  ps aux | sort -nrk 3 | head -n 20
}

# memory usage (top 20)
memtop() {
  ps aux | sort -nrk 4 | head -n 20
}

## storage
# disk usage summary
diskusage() {
  df -h | grep -E 'Filesystem|/dev/'
}

## utils
uuid() {
  uuidgen
}
