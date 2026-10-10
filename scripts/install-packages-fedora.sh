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
  lua-devel \
  luarocks \
  make \
  neovim \
  newsboat \
  ninja-build \
  p7zip \
  pinentry-gnome3 \
  protobuf-compiler \
  pv \
  python3 \
  python3-pip \
  python3-ruff \
  ripgrep \
  ShellCheck \
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

# --- ghostty (copr) ---
if ! installed ghostty; then
  log "installing ghostty..."
  sudo dnf copr enable -y scottames/ghostty
  sudo dnf install -y ghostty
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
fi
# --no-modify-path: cargo is only on PATH once .zshrc runs, so load it here
# shellcheck source=/dev/null
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# --- zsa moonlander: udev access, keymapp, kontroll ---
# hidraw for oryx live training / keymapp api, stm32 dfu for flashing
zsa_rules=/etc/udev/rules.d/50-zsa.rules
if ! grep -q df11 "$zsa_rules" 2>/dev/null; then
  log "installing zsa udev rules..."
  sudo tee "$zsa_rules" >/dev/null <<'RULES'
KERNEL=="hidraw*", ATTRS{idVendor}=="3297", TAG+="uaccess"
SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", TAG+="uaccess"
RULES
  sudo udevadm control --reload
  sudo udevadm trigger
fi

if ! installed keymapp; then
  log "installing keymapp..."
  keymapp_tmp=$(mktemp -d)
  curl -fsSL https://oryx.nyc3.cdn.digitaloceanspaces.com/keymapp/keymapp-latest.tar.gz |
    tar -xz -C "$keymapp_tmp"
  install -m755 "$keymapp_tmp/keymapp" "$HOME/.local/bin/keymapp"
  install -Dm644 "$keymapp_tmp/icon.png" "$HOME/.local/share/icons/hicolor/256x256/apps/keymapp.png"
  rm -rf "$keymapp_tmp"
  mkdir -p "$HOME/.local/share/applications"
  cat >"$HOME/.local/share/applications/keymapp.desktop" <<DESKTOP
[Desktop Entry]
Type=Application
Name=Keymapp
Comment=ZSA keyboard flashing and live layout
Exec=$HOME/.local/bin/keymapp
Icon=keymapp
Categories=Utility;
DESKTOP
fi

# start keymapp at login: kbd-signal / kbd-layer need its api running
mkdir -p "$HOME/.config/autostart"
cat >"$HOME/.config/autostart/keymapp.desktop" <<DESKTOP
[Desktop Entry]
Type=Application
Name=Keymapp
Comment=ZSA keyboard API for kontroll (kbd-signal, kbd-layer)
Exec=$HOME/.local/bin/keymapp
Icon=keymapp
X-GNOME-Autostart-enabled=true
NoDisplay=true
DESKTOP

# api on, autoconnect, start minimised; the db only exists after keymapp's
# first launch, and keymapp must be closed or it rewrites the values
keymapp_db="$HOME/.config/.keymapp/keymapp.sqlite3"
if [[ -f "$keymapp_db" ]] && ! pgrep -x keymapp >/dev/null; then
  log "configuring keymapp..."
  python3 - "$keymapp_db" <<'PY'
import sqlite3, sys
db = sqlite3.connect(sys.argv[1])
for key in ("api_enabled", "startup_autoconnect", "startup_minimized"):
    db.execute("update config set value='1' where key=?", (key,))
db.commit()
PY
fi

# kontroll ships macos binaries only; build it (needs protoc)
if ! installed kontroll; then
  log "installing kontroll..."
  cargo install --locked --git https://github.com/zsa/kontroll --tag 1.0.4
fi

# --- stylua ---
if ! installed stylua; then
  log "installing stylua..."
  sudo dnf install -y stylua 2>/dev/null || \
    cargo install stylua
fi

# --- luacheck (not packaged for recent fedora) ---
if ! installed luacheck; then
  log "installing luacheck..."
  sudo dnf install -y luacheck 2>/dev/null || \
    luarocks install --tree "$HOME/.local" luacheck
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
  herdr plugin install natori-hrj/herdr-lazy --yes
  # shepherd needs a newer go than fedora ships; let go fetch the toolchain
  GOTOOLCHAIN=auto herdr plugin install jwarykowski/shepherd --yes
fi

# --- shepherd cli (used by nvim-shepherd); reuse the plugin's build ---
shepherd_bin=$(compgen -G "$HOME/.config/herdr/plugins/github/jwarykowski.herdr-shepherd-*/bin/shepherd" | head -1 || true)
if [[ -n "$shepherd_bin" ]]; then
  log "linking shepherd..."
  ln -sf "$shepherd_bin" "$HOME/.local/bin/shepherd"
fi

# --- tpm (tmux plugin manager) ---
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
  log "installing tpm..."
  git clone --depth 1 https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

log "fedora packages installed"
