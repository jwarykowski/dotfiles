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
  herdr \
  jq \
  lazygit \
  llvm \
  luacheck \
  neovim \
  newsboat \
  ninja \
  pinentry-mac \
  protobuf \
  pv \
  rbenv \
  ripgrep \
  ruff \
  shellcheck \
  shfmt \
  stow \
  stylua \
  tmux \
  tree-sitter-cli \
  yazi

# --- brew casks ---
log "installing brew casks..."
brew install --cask \
  ghostty \
  font-berkeley-mono \
  keymapp

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
fi
# shellcheck source=/dev/null
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# --- kontroll (moonlander backlight api via keymapp) ---
if ! installed kontroll; then
  log "installing kontroll..."
  cargo install --locked --git https://github.com/zsa/kontroll --tag 1.0.4
fi

# --- bun ---
if ! installed bun; then
  log "installing bun..."
  curl -fsSL https://bun.sh/install | bash
fi

# --- opencode ---
if ! installed opencode; then
  log "installing opencode..."
  brew install sst/tap/opencode
fi

# --- shepherd (cli used by nvim-shepherd) ---
if ! installed shepherd; then
  log "installing shepherd..."
  brew install jwarykowski/tap/shepherd
fi

# --- herdr plugins ---
if installed herdr; then
  log "installing herdr plugins..."
  herdr plugin install paulbkim-dev/vim-herdr-navigation --yes
  herdr plugin install cloudmanic/herdr-plus --yes
  herdr plugin install natori-hrj/herdr-lazy --yes
  # shepherd builds from source and may need a newer go than installed
  GOTOOLCHAIN=auto herdr plugin install jwarykowski/shepherd --yes
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

# --- borders ---
if ! installed borders; then
  log "installing borders..."
  brew tap FelixKratz/formulae
  brew install borders
fi

log "mac packages installed"
