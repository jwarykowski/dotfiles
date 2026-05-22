## files
tarcompress() {
  if [[ $# -lt 2 ]]; then
    echo "usage: tarcompress <directory> <archive.tar.gz>"
    return 1
  fi
  local src="$1"
  local dest="$2"
  local size
  size=$(du -sk "$src" | awk '{print $1}')
  size=$((size * 1024))
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
  size=$(du -sk "$archive" | awk '{print $1}')
  size=$((size * 1024))
  pv -s "$size" "$archive" | tar -xzf - -C "$dest"
}

## utils
uuid() {
  uuidgen
}
