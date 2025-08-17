## directories
# mkdir + cd
mkcd() {
  [[ $# -gt 1 ]] && return 1
  mkdir -p "$1" && cd "$1" || return 1
}


## documentation
# man search
fman() {
  man "$(apropos . | fzf | sed 's/ .*//')"
}


## files
# compress file as tar with progress
tarcompress() {
  if [[ $# -lt 2 ]]; then
    echo "usage: tarcompress <directory> <archive.tar.gz>"
    return 1
  fi
  local src="$1"
  local dest="$2"

  # get total size in bytes
  local size
  size=$(du -sb "$src" | awk '{print $1}')

  # create archive with progress
  tar -cf - "$src" | pv -s "$size" | gzip > "$dest"
}

# uncompress file as tar with progress
taruncompress() {
  if [[ $# -lt 1 ]]; then
    echo "usage: taruncompress <archive.tar.gz> [destination]"
    return 1
  fi
  local archive="$1"
  local dest="${2:-.}"

  # get total size from compressed archive
  local size
  size=$(du -sb "$archive" | awk '{print $1}')

  # extract with progress
  pv -s "$size" "$archive" | tar -xzf - -C "$dest"
}

## networking
# my public ip
myip() {
  curl -s ifconfig.me
}


## processes
# kill process
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]; then
    echo "$pid" | xargs kill -"${1:-9}"
  fi
}

# cpu usage (top 20)
cputop() {
  ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 20
}

# memory usage (top 20)
memtop() {
  ps aux --sort=-%mem | head -n 20
}


## storage
# disk usage summary
diskusage() {
  df -h | grep -E 'Filesystem|/dev/'
}


## utils
uuid() {
  cat /proc/sys/kernel/random/uuid
}
