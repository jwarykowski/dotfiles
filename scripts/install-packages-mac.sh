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
  cloudflared \
  cmake \
  direnv \
  eza \
  fd \
  forgejo-cli \
  fzf \
  gh \
  git \
  git-delta \
  herdr \
  jq \
  lazydocker \
  lazygit \
  llvm \
  luacheck \
  mise \
  neovim \
  newsboat \
  ninja \
  pinentry-mac \
  protobuf \
  pv \
  ripgrep \
  ruff \
  shellcheck \
  shfmt \
  stow \
  stylua \
  tlrc \
  yazi \
  yt-dlp \
  zoxide

# --- brew casks ---
log "installing brew casks..."
brew install --cask \
  ghostty \
  font-berkeley-mono \
  keymapp

# --- runtimes + npm globals (mise, see common/.config/mise/config.toml) ---
# packages run before stow, so point mise at the repo's config
log "installing mise tools..."
MISE_GLOBAL_CONFIG_FILE="$(cd "$(dirname "$0")/.." && pwd)/common/.config/mise/config.toml"
export MISE_GLOBAL_CONFIG_FILE
# npm: tools need node first
mise install node
mise install

# --- rust ---
if ! installed rustup; then
  log "installing rust..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
fi
# shellcheck source=/dev/null
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# --- keymapp at login (hidden): kbd-layer needs its api running ---
if [[ -d /Applications/Keymapp.app ]] &&
  ! osascript -e 'tell application "System Events" to get the name of every login item' | grep -q Keymapp; then
  log "adding keymapp login item..."
  osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Keymapp.app", hidden:true}' >/dev/null
fi

# --- kontroll (moonlander backlight api via keymapp) ---
if ! installed kontroll; then
  log "installing kontroll..."
  cargo install --locked --git https://github.com/zsa/kontroll --tag 1.0.4
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
  herdr_plugins=$(herdr plugin list)
  # leave local dev checkouts (herdr plugin link) alone; install refuses them
  plugin_install() {
    if grep -q "local:.*/${1#*/}]" <<<"$herdr_plugins"; then
      log "skipping $1 (linked locally)"
      return
    fi
    herdr plugin install "$1" --yes
  }
  plugin_install paulbkim-dev/vim-herdr-navigation
  plugin_install cloudmanic/herdr-plus
  plugin_install natori-hrj/herdr-lazy
  plugin_install jwarykowski/herdr-keybars
  # shepherd builds from source and may need a newer go than installed
  GOTOOLCHAIN=auto plugin_install jwarykowski/shepherd
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
