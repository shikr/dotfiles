#!/usr/bin/env bash

options=(kitty neovim rofi spotify_player zsh)
config_dir="$HOME/.config"

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
  print_option "    --no-ohmyzsh         " "Don't install oh-my-zsh"
  print_option "    --no-p10k            " "Don't install powerlevel10k"
  print_option "-i, --ignore <OPTIONS>   " "Don't install specified files (-i zsh,rofi)"
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

clone_plugin() {
  [[ ! -d "$ZSH_PLUGINS_DIR/$2" ]] && git clone "https://github.com/${1}/${2}.git" "$ZSH_PLUGINS_DIR/$2"
}

backup() {
  if [[ -d "$1" ]]; then
    [[ "$delete" != "true" ]] && cp -r "$1" "${1}.backup"
    rm -rf "$1"
  fi
}

copy_files() {
  if [[ "$symlink" == "true" ]]; then
    ln -s "$1" "$2"
  else
    cp -r "$1" "$2"
  fi
}

print_progress() {
  [[ "$silent" != "true" ]] && printf "${color_blue}%s${color_white}$2" "$1"
}

start_progress() {
  print_progress "Installing $1..."
}

finish_progress() {
  echo -ne "\r\033[K"
  print_progress "Installed $1" "\n"
}

setup() {
  start_progress "$1"
  backup "${config_dir}/$1"
  [[ "$silent" != "true" ]] && sleep 0.7
  copy_files "$1" "$config_dir"
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
    --no-ohmyzsh)
      ohmyzsh="false"
      shift
    ;;
    --no-p10k)
      p10k="false"
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
  start_progress neovim
  backup "${config_dir}/nvim"
  backup "$HOME/.local/share/nvim"
  git clone https://github.com/NvChad/NvChad.git "${config_dir}/nvim" --depth=1
  copy_files nvchad/custom "${config_dir}/nvim/lua"
  print_progress "Installed neovim" "\n"
fi

if [[ "$zsh" != "false" ]]; then
  start_progress zsh
  backup "$HOME/.zshrc"
  if [[ "$ohmyzsh" != "false" ]]; then
    if command_exists "curl"; then
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    elif command_exists "wget"; then
      sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    else
      send_error "\`curl\` or \`wget\` is required to install oh-my-zsh."
    fi
  fi

  copy_files .zshrc "${HOME}"

  if [[ "$plugins" != "false" ]]; then
    ZSH_PLUGINS_DIR="${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom}/plugins"
    [[ ! -d $ZSH_PLUGINS_DIR ]] && mkdir -p $ZSH_PLUGINS_DIR

    clone_plugin buonomo           yarn-extra-completion
    clone_plugin grigorii-zander   zsh-npm-scripts-autocomplete
    clone_plugin redxtech          zsh-kitty
    clone_plugin MenkeTechnologies zsh-cargo-completion
    clone_plugin zshzoo            cd-ls
    clone_plugin hlissner          zsh-autopair
    clone_plugin zsh-users         zsh-autosuggestions
    clone_plugin zsh-users         zsh-syntax-highlighting
  fi

  copy_files .p10k.zsh "${HOME}"

  if [[ "$p10k" != "false" ]]; then
    ZSH_THEMES_DIR="${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom}/themes"
    [[ ! -d $ZSH_THEMES_DIR ]] && mkdir -p $ZSH_THEMES_DIR

    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_THEMES_DIR/powerlevel10k
  fi

  print_progress "Installed zsh" "\n"
fi
