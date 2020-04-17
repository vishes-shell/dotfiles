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

# . "$HOME/.completions/gh-complete.sh"
# . "$HOME/.completions/watson-complete.sh"

autoload -Uz compinit && compinit
export PATH="/usr/local/opt/libpq/bin:$PATH"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
