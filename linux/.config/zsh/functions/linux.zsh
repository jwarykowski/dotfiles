## files
tarcompress() {
  if [[ $# -lt 2 ]]; then
    echo "usage: tarcompress <directory> <archive.tar.gz>"
    return 1
  fi
  local src="$1"
  local dest="$2"
  local size
  size=$(du -sb "$src" | awk '{print $1}')
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
  size=$(du -sb "$archive" | awk '{print $1}')
  pv -s "$size" "$archive" | tar -xzf - -C "$dest"
}

zipcompress() {
  if [[ $# -lt 2 ]]; then
    echo "usage: zipcompress <directory> <archive.zip>"
    return 1
  fi
  local src="$1"
  local dest="$2"
  mkdir -p "$(dirname "$dest")"
  7z a -tzip "$dest" "$src" -mx=9
}

zipuncompress() {
  if [[ $# -lt 1 ]]; then
    echo "usage: zipuncompress <archive.zip> [destination]"
    return 1
  fi
  local archive="$1"
  local dest="${2:-.}"
  mkdir -p "$dest"
  7z x "$archive" -o"$dest" -y
}

## utils
uuid() {
  cat /proc/sys/kernel/random/uuid
}
