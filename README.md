<div align="center">
  <h1>Dotfiles</h1>
</div>

<p align="center">
  <img src="assets/neovim.png" width="400">
  <img src="assets/rofi.png" width="400">
  <img src="assets/spotify-player.png" width="400">
</p>

## Details

- **Compositor**: [niri](https://github.com/YaLTeR/niri)
- **Bar**: [ags](https://github.com/Aylur/ags)
- **Terminal**: [kitty](https://github.com/kovidgoyal/kitty/)
- **Shell**: [zsh](https://www.zsh.org/)
- **Editor**: [neovim](https://github.com/neovim/neovim)
- **File Manager**: [superfile](https://github.com/yorukot/superfile)
- **Application Launcher**: [rofi](https://github.com/davatorium/rofi)
- **Music Player**: [spotify-player](https://github.com/aome510/spotify-player)
- **Font**: [FiraCode NerdFont](https://www.nerdfonts.com/font-downloads)

## Setup

### Required Dependencies

- [WirePlumber](https://pipewire.pages.freedesktop.org/wireplumber/) and [Playerctl](https://github.com/altdesktop/playerctl) for niri.
- [astal](https://aylur.github.io/astal/), [esbuild](https://esbuild.github.io/) and [accountsservice](https://gitlab.freedesktop.org/accountsservice/accountsservice) for ags.
- [FiraCode NerdFont](https://www.nerdfonts.com/font-downloads), [Inter Font](https://rsms.me/inter/) and [Symbols NerdFont](https://www.nerdfonts.com/font-downloads) for kitty and rofi.
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation), [Node.js](https://nodejs.org/es/download), [Yarn](https://classic.yarnpkg.com/lang/en/docs/install/) and [Rust](https://www.rust-lang.org/tools/install) for neovim.
- [exiftool](https://exiftool.org/) for superfile.
- [oh my zsh](https://ohmyz.sh/) and [fzf](https://github.com/junegunn/fzf) for zsh.

> Clone this repository

```sh
git clone https://github.com/shikr/dotfiles.git
cd dotfiles
```

> Run installation script

Using npx

```sh
./install.mjs
```

Or with [pnpm](https://pnpm.io/)

```sh
pnpm install
pnpm start
```

### Customize your installation

Usage: `./install.mjs [OPTIONS] [...CONFIGS]`

```
Options:
  -p, --zsh-plugins      Install zsh plugins. (default: true)
  -S, --symlink          Create symlinks instead of copying files. (default: true)
  -b, --backup           Backup existing files. (default: true)
  -I, --install          Install all configurations. If disabled, the script will only do a dry run. (default: true)
  -B, --scripts          Install provided scripts. (default: true)
  -i, --ignore <CONFIGS> Ignore configurations. (-i zsh,rofi)
                         CONFIGS: zsh, niri, kitty, rofi, spotify_player, nvim, superfile, ags, starship

  -s, --silent           Suppress output.
  -h, --help             Show this help message.
```

## Credits

- [Rofi Theme](https://github.com/adi1090x/rofi)
- [Rofi Background Image](https://www.pixiv.net/artworks/60839445)
