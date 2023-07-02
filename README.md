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

- [FiraCode NerdFont](https://www.nerdfonts.com/font-downloads) for kitty and rofi.
- [Node.js](https://nodejs.org/es/download), [Yarn](https://classic.yarnpkg.com/lang/en/docs/install/) and [Rust](https://www.rust-lang.org/tools/install) for neovim.

> Clone this repository

```sh
git clone https://github.com/S4bier/dotfiles.git
cd dotfiles
```

> Run installation script

```sh
./install.sh
```

### Customize your installation

Usage: `./install.sh [OPTIONS...]`

```sh
Options:
  -p, --no-zsh-plugins      Don't install zsh plugins
  -S, --symlink             Create symlinks instead of copying files
  -d, --delete, --no-backup Don't create backup files
      --no-ohmyzsh          Don't install oh-my-zsh
      --no-p10k             Don't install powerlevel10k
  -i, --ignore <OPTIONS>    Don't install specified files (-i zsh,rofi)
                            OPTIONS: kitty, neovim, rofi, spotify_player, zsh
  -s, --silent              Don't show progress messages
  -h, --help                Show this help message
```

## Credits

- [Rofi Theme](https://github.com/adi1090x/rofi)
- [Rofi Background Image](https://www.pixiv.net/artworks/60839445)
