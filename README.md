<div align="center">
  <h1>Dotfiles</h1>
</div>

<p align="center">
  <img src="assets/neovim.png" width="400">
  <img src="assets/rofi.png" width="400">
  <img src="assets/spotify-player.png" width="400">
</p>

## Details

- **Terminal**: [kitty](https://github.com/kovidgoyal/kitty/)
- **Shell**: [zsh](https://www.zsh.org/)
- **Editor**: [neovim](https://github.com/neovim/neovim)
- **Application Launcher**: [rofi](https://github.com/davatorium/rofi)
- **Music Player**: [spotify-player](https://github.com/aome510/spotify-player)
- **Font**: [FiraCode NerdFont](https://www.nerdfonts.com/font-downloads)

## Setup

### Required Dependencies

- [FiraCode NerdFont](https://www.nerdfonts.com/font-downloads), [Inter Font](https://rsms.me/inter/) and [Symbols NerdFont](https://www.nerdfonts.com/font-downloads) for kitty and rofi.
- [Lua 5.1](https://www.lua.org/download.html), [ripgrep](https://github.com/BurntSushi/ripgrep#installation), [ImageMagick](https://imagemagick.org/script/download.php), [Node.js](https://nodejs.org/es/download), [Yarn](https://classic.yarnpkg.com/lang/en/docs/install/) and [Rust](https://www.rust-lang.org/tools/install) for neovim.
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

Usage: `./install.mjs [OPTIONS...]`

```
Options:
  -p, --zsh-plugins      Install zsh plugins. (default: true)
  -S, --symlink          Create symlinks instead of copying files. (default: true)
  -b, --backup           Backup existing files. (default: true)
  -I, --install          Install all configurations. If disabled, the script will only do a dry run. (default: true)
  -i, --ignore <OPTIONS> Ignore configurations. (-i zsh,rofi)
                         OPTIONS: zsh, kitty, rofi, spotify_player, nvim, starship

  -s, --silent           Suppress output.
  -h, --help             Show this help message.
```

## Credits

- [Rofi Theme](https://github.com/adi1090x/rofi)
- [Rofi Background Image](https://www.pixiv.net/artworks/60839445)
