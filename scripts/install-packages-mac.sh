#!/usr/bin/env bash
set -euo pipefail

log() { echo "==> $*"; }
installed() { command -v "$1" >/dev/null 2>&1; }

# --- homebrew ---
if ! installed brew; then
  log "installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# --- brew packages ---
log "installing brew packages..."
brew install \
  bat \
  btop \
  cmake \
  direnv \
  eza \
  fd \
  fnm \
  fzf \
  gh \
  git \
  git-delta \
  go \
  jq \
  lazygit \
  llvm \
  neovim \
  ninja \
  pv \
  rbenv \
  ripgrep \
  ruff \
  shfmt \
  stow \
  stylua \
  tmux \
  yazi

# --- brew casks ---
log "installing brew casks..."
brew install --cask \
  ghostty \
  font-berkeley-mono

# --- node + npm globals ---
eval "$(fnm env)"
if ! installed node; then
  log "installing node lts..."
  fnm install --lts
  fnm use lts-latest
fi

log "installing npm globals..."
npm install -g @fsouza/prettierd prettier

# --- rust ---
if ! installed rustup; then
  log "installing rust..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
  source "$HOME/.cargo/env"
fi

# --- bun ---
if ! installed bun; then
  log "installing bun..."
  curl -fsSL https://bun.sh/install | bash
fi

# --- tpm (tmux plugin manager) ---
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
  log "installing tpm..."
  git clone --depth 1 https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# --- aerospace ---
if ! installed aerospace; then
  log "installing aerospace..."
  brew install --cask nikitabobko/tap/aerospace
fi

# --- yabai + skhd ---
if ! installed yabai; then
  log "installing yabai..."
  brew install koekeishiya/formulae/yabai
  yabai --start-service
fi

if ! installed skhd; then
  log "installing skhd..."
  brew install koekeishiya/formulae/skhd
  skhd --start-service
fi

# --- borders ---
if ! installed borders; then
  log "installing borders..."
  brew tap FelixKratz/formulae
  brew install borders
fi

log "mac packages installed"
