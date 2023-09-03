#!/usr/bin/env bash

options=(kitty neovim rofi spotify_player zsh starship)
CONFIG_DIR="$HOME/.config"
CURRENT_DIR="$(dirname "$(readlink -f "$0")")"

color_red="\033[1;31m"
color_white="\033[0m"
color_green="\033[1;32m"
color_blue="\033[1;34m"

print_option() {
  printf "  %s %s\n" "$1" "$2"
}

show_help() {
  printf "${color_green}%s ${color_white}%s %s %s\n\n" "Usage:" "$0" "[OPTIONS...]"
  printf "${color_green}%s\n${color_white}" "Options:"

  print_option "-p, --no-zsh-plugins     " "Don't install zsh plugins"
  print_option "-S, --symlink            " "Create symlinks instead of copying files"
  print_option "-d, --delete, --no-backup" "Don't create backup files"
  print_option "-i, --ignore <OPTIONS>   " "Don't install specified files (-i zsh,rofi)"
  print_option "                         " "OPTIONS: kitty, neovim, rofi, spotify_player, zsh, starship"
  print_option "-s, --silent             " "Don't show progress messages"
  print_option "-h, --help               " "Show this help message"
}

send_error() {
  printf "${color_red}%s ${color_white}%s\n" "error:" "$1"
  exit 1
}

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

valid_option() {
  for option in "${options[@]}";
  do
    if [ "$1" == "$option" ]; then
      return 0
    fi
  done
  send_error "Invalid option: $1"
}

backup() {
  if [[ -d "$1" || -f "$1" ]]; then
    [[ "$delete" != "true" ]] && cp -r "$1" "${1}.backup"
    rm -rf "$1"
  fi
}

copy_files() {
  if [[ "$symlink" == "true" ]]; then
    ln -s "${CURRENT_DIR}/$1" "$2"
  else
    cp -r "$1" "$2"
  fi
}

print_progress() {
  [[ "$silent" != "true" ]] && printf "${color_blue}%s${color_white}$2" "$1"
}

start_progress() {
  print_progress "Installing $1..." "$2"
}

finish_progress() {
  echo -ne "\r\033[K"
  print_progress "Installed $1" "\n"
}

clone_plugin() {
  if [[ ! -d "$ZSH_PLUGINS_DIR/$2" ]]; then
    print_progress "Cloning $2 plugin..." "\n"
    git clone "https://github.com/${1}/${2}.git" "$ZSH_PLUGINS_DIR/$2"
  else
    print_progress "Already installed '$2' plugin" "\n"
  fi
}

setup() {
  start_progress "$1"
  backup "${CONFIG_DIR}/$1"
  [[ "$silent" != "true" ]] && sleep 0.7
  copy_files "$1" "$CONFIG_DIR"
  finish_progress "$1"
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -p | --no-zsh-plugins)
      plugins="false"
      shift
    ;;
    -S | --symlink)
      symlink="true"
      shift
    ;;
    -d | --delete | --no-backup)
      delete="true"
      shift
    ;;
    -i | --ignore)
      [[ -z $2 ]] && send_error "a value is required for 'ignore'" || ignore="$2"
      shift 2
    ;;
    -s | --silent)
      silent="true"
      shift
    ;;
    -h | --help | help)
      show_help
      exit 0
    ;;
    -* | --*)
      send_error "unknown option: \`$1\`"
    ;;
    *)
      send_error "no such command: \`$1\`"
  esac
done

if [[ ! -z $ignore ]]; then
  IFS=','
  for i in $ignore;
  do
    valid_option "$i" && eval "${i}"="false"
  done
fi

[[ "$kitty" != "false" ]] && setup kitty

[[ "$rofi" != "false" ]] && setup rofi

[[ "$spotify_player" != "false" ]] && setup spotify-player

if [[ "$neovim" != "false" ]]; then
  start_progress neovim "\n"
  backup "${CONFIG_DIR}/nvim"
  backup "$HOME/.local/share/nvim"
  git clone https://github.com/NvChad/NvChad.git "${CONFIG_DIR}/nvim" --depth=1
  copy_files nvchad/custom "${CONFIG_DIR}/nvim/lua"
  print_progress "Installed neovim" "\n"
fi

if [[ "$zsh" != "false" ]]; then
  start_progress zsh "\n"
  backup "$HOME/.zshrc"

  copy_files .zshrc "${HOME}"

  if [[ "$plugins" != "false" ]]; then
    ZSH_PLUGINS_DIR="${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom}/plugins"
    [[ ! -d $ZSH_PLUGINS_DIR ]] && mkdir -p $ZSH_PLUGINS_DIR

    clone_plugin grigorii-zander   zsh-npm-scripts-autocomplete
    clone_plugin redxtech          zsh-kitty
    clone_plugin MenkeTechnologies zsh-cargo-completion
    clone_plugin zshzoo            cd-ls
    clone_plugin hlissner          zsh-autopair
    clone_plugin zsh-users         zsh-autosuggestions
    clone_plugin zsh-users         zsh-syntax-highlighting
    clone_plugin zsh-users         zsh-completions
  fi

  print_progress "Installed zsh" "\n"
fi

if [[ "$starship" != "false" ]]; then
  start_progress starship
  backup "$HOME/.config/starship.toml"
  copy_files starship.toml "${HOME}/.config"
  finish_progress starship
fi
