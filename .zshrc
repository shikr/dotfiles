export PATH=$PATH:$HOME/.local/bin:/usr/local/bin:~/.npm-global/bin

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# DISABLE_AUTO_TITLE="true"

ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git rust sudo command-not-found zsh-interactive-cd zsh-npm-scripts-autocomplete zsh-kitty zsh-cargo-completion cd-ls zsh-autosuggestions zsh-autopair zsh-syntax-highlighting)

fpath+=${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom}/plugins/zsh-completions/src

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# export EDITOR='nano'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

command -v lsd >/dev/null && alias ls="lsd"
alias la="ls -a"

export NPM_CONFIG_PREFIX=~/.npm-global

command -v starship >/dev/null && eval "$(starship init zsh)"

zle-line-init() {
  [[ $CONTEXT == start ]] || return 0

  (( $+zle_bracketed_paste )) && print -r -n - $zle_bracketed_paste[1]
  zle .recursive-edit
  local -i ret=$?
  (( $+zle_bracketed_paste )) && print -r -n - $zle_bracketed_paste[2]

  local old_prompt=$PROMPT
  local old_rprompt=$RPROMPT
  PROMPT=$(starship module character)
  RPROMPT=""

  zle .reset-prompt
  [[ $ret == 0 && $KEYS == $'\4' ]] && exit

  PROMPT=$old_prompt
  RPROMPT=$old_rprompt

  if (( ret )); then
    zle .send-break
  else
    zle .accept-line
  fi
  return ret
}