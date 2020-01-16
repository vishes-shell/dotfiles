export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="spaceship"

CASE_SENSITIVE="false"

HIST_STAMPS="dd.mm.yyyy"

set -o vi

plugins=(
  gitfast
  django
  brew
  vi-mode
  fzf
)

source $ZSH/oh-my-zsh.sh
source "$HOME/.shell/.exports"
source "$HOME/.shell/.aliases"
source "$HOME/.shell/.functions"
source "$HOME/.aliases"
. "$HOME/.shell/.click-complete.sh"
