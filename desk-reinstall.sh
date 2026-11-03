#!/usr/bin/env bash
# Linux reinstall script with my apps :)
# Run on a fresh install:  bash desk-reinstall.sh

set -euo pipefail

# ─────────────────────────────────────────────────────────────
# APT packages (official repos)
# ─────────────────────────────────────────────────────────────
APT_PACKAGES=(
  bridge-utils
  chromium
  clamav
  ffmpeg
  git
  htop
  i3
  i3lock
  pavucontrol
  tmux
  virt-manager
  vulkan-tools
  xclip
  xournalpp
)

# ─────────────────────────────────────────────────────────────
# Flatpaks (flathub)
# ─────────────────────────────────────────────────────────────
FLATPAKS=(
  app.zen_browser.zen
  com.discordapp.Discord
  com.github.tchx84.Flatseal
  com.github.wwmm.easyeffects
  com.heroicgameslauncher.hgl
  com.obsproject.Studio
  com.usebottles.bottles
  io.gitlab.librewolf-community
  org.kde.kdenlive
  org.keepassxc.KeePassXC
)

# ─────────────────────────────────────────────────────────────
# Vendor installs (official procedures), set to false to skip
# ─────────────────────────────────────────────────────────────
INSTALL_GH=true          # GitHub CLI, cli.github.com apt repo
INSTALL_MULLVAD=true     # Mullvad VPN, repository.mullvad.net apt repo
INSTALL_PROTONVPN=true   # Proton VPN, repo package + proton-vpn-gnome-desktop
INSTALL_KITTY=true       # kitty, official binary installer

# Proton VPN repo package. If Proton releases a new one, update both values
# from https://protonvpn.com/support/linux-vpn-debian-ubuntu
PROTON_DEB="protonvpn-stable-release_1.0.10_all.deb"
PROTON_SHA256="c8a9fffb4ebdd63db08ce7f11c9b0ac394064ae6a210feb9ab63a0f7d8d060a7"

# ═════════════════════════════════════════════════════════════
# Nothing to edit below this line
# ═════════════════════════════════════════════════════════════

log() { printf '\n\033[1;34m==> %s\033[0m\n' "$*"; }

WORKDIR="$(mktemp -d)"
trap 'rm -rf "$WORKDIR"' EXIT

sudo -v   # ask for the password once up front

VENDOR_PKGS=()

if [[ "$INSTALL_GH" == true ]]; then
  log "Adding GitHub CLI repo"
  sudo mkdir -p -m 755 /etc/apt/keyrings /etc/apt/sources.list.d
  wget -nv -O "$WORKDIR/gh.gpg" https://cli.github.com/packages/githubcli-archive-keyring.gpg
  sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg < "$WORKDIR/gh.gpg" > /dev/null
  sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
    | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
  VENDOR_PKGS+=(gh)
fi

if [[ "$INSTALL_MULLVAD" == true ]]; then
  log "Adding Mullvad repo"
  sudo curl -fsSLo /usr/share/keyrings/mullvad-keyring.asc https://repository.mullvad.net/deb/mullvad-keyring.asc
  echo "deb [signed-by=/usr/share/keyrings/mullvad-keyring.asc arch=$(dpkg --print-architecture)] https://repository.mullvad.net/deb/stable stable main" \
    | sudo tee /etc/apt/sources.list.d/mullvad.list > /dev/null
  VENDOR_PKGS+=(mullvad-vpn)
fi

if [[ "$INSTALL_PROTONVPN" == true ]]; then
  log "Adding Proton VPN repo"
  (
    cd "$WORKDIR"
    wget -nv "https://repo.protonvpn.com/debian/dists/stable/main/binary-all/$PROTON_DEB"
    echo "$PROTON_SHA256 $PROTON_DEB" | sha256sum --check -
    sudo dpkg -i "./$PROTON_DEB"
  )
  VENDOR_PKGS+=(proton-vpn-gnome-desktop)
fi

log "Updating package lists"
sudo apt update

log "Installing apt packages"
sudo apt install -y "${APT_PACKAGES[@]}" "${VENDOR_PKGS[@]}"

log "Installing flatpaks"
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y --noninteractive flathub "${FLATPAKS[@]}"

if [[ "$INSTALL_KITTY" == true ]]; then
  log "Installing kitty"
  # Installs to ~/.local/kitty.app as your user (no sudo)
  curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin launch=n
  mkdir -p ~/.local/bin ~/.local/share/applications ~/.config
  ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
  cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
  cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
  sed -i "s|Icon=kitty|Icon=$(readlink -f ~)/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
  sed -i "s|Exec=kitty|Exec=$(readlink -f ~)/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
  # Make kitty the default terminal for xdg-terminal-exec
  echo 'kitty.desktop' > ~/.config/xdg-terminals.list
fi

# After install, to use virt-manager without a password prompt
# (then log out and back in):
# sudo usermod -aG libvirt $USER

log "Done"
