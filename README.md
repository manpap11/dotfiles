# Dotfiles

This is just a repo where I save and share my dotfiles (.config)

## Environment Variables

Since a lot of applications place their config files in random places you should set the **XDG environment variables** to introduce ***some sense*** of cross compatibility in case some applications make use of the standard.

In your ~/.profile add:

```bash
export XDG_CONFIG_HOME="$HOME/.config"
```

You should download your LSPs of your choice and create a symlink to the "lsp" folder you will create for easier management of the LSPs.

```bash
ln -s ~/Downloads/<your_chosen_path_anyway> $HOME/.local/share/nvim/lsp
```

In your ~/.bashrc add:

```bash
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export PATH="$PATH:$HOME/.local/share/nvim/lsp"
```

## Linux Apps Reinstall Script

`desk-reinstall.sh` sets up a fresh Linux install with the packages I use. It targets Debian/Ubuntu based distros.

### What it installs

- **APT packages** from the official repos: CLI tools (git, htop, tmux, xclip, ffmpeg), i3, Chromium, ClamAV, Xournal++ and virtualization (virt-manager, which also brings in libvirt, QEMU/KVM, OVMF and swtpm)
- **Flatpaks** from Flathub: Zen Browser, LibreWolf, Discord, OBS, Kdenlive, KeePassXC, Bottles, Heroic, EasyEffects, Flatseal
- **Vendor installs**, each following the vendor's official procedure:
  - [GitHub CLI](https://github.com/cli/cli/blob/trunk/docs/install_linux.md#debian) through its official apt repo
  - [Mullvad VPN](https://mullvad.net/en/download/vpn/linux) through its official apt repo
  - [Proton VPN](https://protonvpn.com/support/linux-vpn-debian-ubuntu) through its repo package
  - [kitty](https://sw.kovidgoyal.net/kitty/binary/) through the official binary installer, with desktop integration

### Usage

```bash
git clone <this-repo-url>
cd <repo-folder>
chmod +x desk-reinstall.sh
./desk-reinstall.sh
```

It asks for your sudo password once at the start. The script stops at the first error (`set -euo pipefail`), so nothing is left half-configured.

### Customizing

Edit the variables at the top of the script:

- `APT_PACKAGES` and `FLATPAKS`: add or remove one package per line
- `INSTALL_GH`, `INSTALL_MULLVAD`, `INSTALL_PROTONVPN`, `INSTALL_KITTY`: set to `false` to skip

### Notes

- **Proton VPN checksum:** the script pins the Proton repo package filename and SHA256. If Proton releases a new version, the checksum check fails and the script stops. Update `PROTON_DEB` and `PROTON_SHA256` from [Proton's guide](https://protonvpn.com/support/linux-vpn-debian-ubuntu) and run it again.
- **kitty** becomes the default terminal through `~/.config/xdg-terminals.list`. Remove that line from the script if you don't want this.
- **After installing**, to use virt-manager without a password prompt, run the following and then log out and back in:
  ```bash
  sudo usermod -aG libvirt $USER
  ```
- Log out and back in for kitty and the flatpaks to appear in the menu.
