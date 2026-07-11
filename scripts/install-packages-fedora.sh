#!/usr/bin/env bash
set -euo pipefail

log() { echo "==> $*"; }
installed() { command -v "$1" >/dev/null 2>&1; }

# --- system packages ---
log "installing dnf packages..."
sudo dnf install -y \
  bat \
  btop \
  clang \
  clang-tools-extra \
  cmake \
  direnv \
  eza \
  fd-find \
  fzf \
  gcc \
  gh \
  git \
  git-delta \
  golang \
  jq \
  luacheck \
  make \
  neovim \
  ninja-build \
  p7zip \
  pinentry-gnome3 \
  pv \
  python3 \
  python3-pip \
  python3-ruff \
  ripgrep \
  shfmt \
  stow \
  tmux \
  unzip \
  zsh

# --- lazygit (copr) ---
if ! installed lazygit; then
  log "installing lazygit..."
  sudo dnf copr enable -y atim/lazygit
  sudo dnf install -y lazygit
fi

# --- yazi (copr) ---
if ! installed yazi; then
  log "installing yazi..."
  sudo dnf copr enable -y lihaohong/yazi
  sudo dnf install -y yazi
fi

# --- rust ---
if ! installed rustup; then
  log "installing rust..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
  source "$HOME/.cargo/env"
fi

# --- stylua ---
if ! installed stylua; then
  log "installing stylua..."
  sudo dnf install -y stylua 2>/dev/null || \
    cargo install stylua
fi

# --- fnm + node ---
if ! installed fnm; then
  log "installing fnm..."
  curl -fsSL https://fnm.vercel.app/install | bash -s -- \
    --install-dir "$HOME/.local/bin" \
    --skip-shell
fi

eval "$("$HOME/.local/bin/fnm" env)"
if ! installed node; then
  log "installing node lts..."
  fnm install --lts
  fnm use lts-latest
fi

# --- npm globals ---
log "installing npm globals..."
npm config set prefix "$HOME/.local"
npm install -g @fsouza/prettierd prettier tree-sitter-cli

# --- bun ---
if ! installed bun; then
  log "installing bun..."
  curl -fsSL https://bun.sh/install | bash
fi

# --- herdr ---
if ! installed herdr; then
  log "installing herdr..."
  curl -fsSL https://herdr.dev/install.sh | sh
fi

# --- herdr plugins ---
if installed herdr; then
  log "installing herdr plugins..."
  herdr plugin install paulbkim-dev/vim-herdr-navigation --yes
  herdr plugin install cloudmanic/herdr-plus --yes
fi

# --- tpm (tmux plugin manager) ---
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
  log "installing tpm..."
  git clone --depth 1 https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

log "fedora packages installed"
