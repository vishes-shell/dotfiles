export PATH=$HOME/.poetry/bin:$HOME/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="spaceship"

CASE_SENSITIVE="false"

export DISABLE_AUTO_TITLE="true"

HIST_STAMPS="dd.mm.yyyy"

set -o vi

plugins=(
  gitfast
  django
  brew
  vi-mode
  fzf
  poetry
)

source $ZSH/oh-my-zsh.sh
source "$HOME/.shell/.exports"
source "$HOME/.shell/.aliases"
source "$HOME/.shell/.functions"
source "$HOME/.aliases"

autoload -Uz compinit && compinit
