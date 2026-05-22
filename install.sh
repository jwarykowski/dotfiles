#!/usr/bin/env bash
set -euo pipefail

adopt=false
packages=false
while [[ $# -gt 0 ]]; do
  case "$1" in
    --adopt)    adopt=true; shift ;;
    --packages) packages=true; shift ;;
    *) echo "unknown option: $1" >&2; exit 1 ;;
  esac
done

# detect os
os="$(uname -s | tr '[:upper:]' '[:lower:]')"
case "$os" in
    darwin) platform="mac";    pkg_platform="mac" ;;
    linux)  platform="linux";  pkg_platform="fedora" ;;
    *)      echo "unsupported os: $os" >&2; exit 1 ;;
esac

echo "detected platform: $platform"

# location of dotfiles repo (assumes script is run from repo root)
dotfiles_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$dotfiles_dir"

# install packages if requested
if [[ "$packages" == "true" ]]; then
  pkg_script="$dotfiles_dir/scripts/install-packages-$pkg_platform.sh"
  if [[ -x "$pkg_script" ]]; then
    echo "installing packages for $pkg_platform..."
    bash "$pkg_script"
  else
    echo "no package script found at $pkg_script" >&2
  fi
fi

# make sure stow is installed
if ! command -v stow >/dev/null 2>&1; then
    echo "gnu stow is not installed. please install it first:"
    if [ "$platform" = "mac" ]; then
        echo "  brew install stow"
    else
        echo "  sudo dnf install stow    # fedora"
        echo "  sudo apt install stow    # debian/ubuntu"
    fi
    exit 1
fi

# ensure directories referenced in .zshenv exist
mkdir -p "$HOME/.cache/tmp"

stow_flags="-v --restow"
if [[ "$adopt" == "true" ]]; then
  stow_flags="-v --adopt"
fi

# always stow "common" if it exists
if [ -d "common" ]; then
    echo "stowing common configs..."
    stow $stow_flags common
fi

# stow platform-specific configs
if [ -d "$platform" ]; then
    echo "stowing $platform configs..."
    stow $stow_flags "$platform"
fi

echo "thy dotfiles be stowed for $platform"
