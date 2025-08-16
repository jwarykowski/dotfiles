#!/usr/bin/env bash
set -euo pipefail

# detect os
os="$(uname -s | tr '[:upper:]' '[:lower:]')"
case "$os" in
    darwin) platform="mac" ;;
    linux)  platform="linux" ;;
    *)      echo "unsupported os: $os" >&2; exit 1 ;;
esac

echo "detected platform: $platform"

# location of dotfiles repo (assumes script is run from repo root)
dotfiles_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$dotfiles_dir"

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

# always stow "common" if it exists
if [ -d "common" ]; then
    echo "stowing common configs..."
    stow -v common
fi

# stow platform-specific configs
if [ -d "$platform" ]; then
    echo "stowing $platform configs..."
    stow -v "$platform"
fi

echo "thy dotfiles be stowed for $platform"
