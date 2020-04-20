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
source "$HOME/.exports"
source "$HOME/.aliases"
source "$HOME/.functions"
source "$HOME/.fzf.zsh"

autoload -Uz compinit && compinit
export PATH="/usr/local/opt/libpq/bin:$PATH"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"

export REPORTTIME=10

