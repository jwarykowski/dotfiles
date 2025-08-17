# recursively source all files with a given extension
source_recursive() {
  local dir="$1"
  local ext="$2"

  if [[ -z "$dir" || -z "$ext" ]]; then
    echo "usage: source_recursive <directory> <extension>"
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
