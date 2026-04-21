# source all files with a given extension in a directory
source_dir() {
  local dir="$1"
  local ext="$2"

  if [[ -z "$dir" || -z "$ext" ]]; then
    echo "usage: source_dir <directory> <extension>"
    return 1
  fi

  if [[ ! -d "$dir" ]]; then
    echo "directory not found: $dir"
    return 1
  fi

  for file in "$dir"/*."$ext"; do
    if [[ -r "$file" ]]; then
      source "$file"
    fi
  done
}
