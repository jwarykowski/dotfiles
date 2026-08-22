## files
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
