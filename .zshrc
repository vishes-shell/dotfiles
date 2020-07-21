export PATH=$HOME/.poetry/bin:$HOME/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="spaceship"

CASE_SENSITIVE="false"

export DISABLE_AUTO_TITLE="true"

HIST_STAMPS="dd.mm.yyyy"

set -o vi

plugins=(
  gitfast
  brew
  vi-mode
  fzf
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

export PATH="/usr/local/opt/gettext/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/gettext/lib"
export CPPFLAGS="-I/usr/local/opt/gettext/include"


export REPORTTIME=10

export PROMPT_COMMAND='echo -ne "\033]0;$(basename ${PWD})\007"'
