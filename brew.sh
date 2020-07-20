#!/usr/bin/env bash

echo " > Install Xcode tools"
xcode-select --install

echo " > Install brew"
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor
brew update

echo " > Install Kitty"
brew cask install kitty

echo " > Install git"
brew install git

echo " > Install zsh"
brew install zsh
echo "$(brew --prefix)/bin/zsh" | sudo tee -a /etc/shells
chsh -s "$(brew --prefix)/bin/zsh"

echo " > Install fzf"
brew install fzf
/usr/local/opt/fzf/install

echo " > Install Silver Searcher"
brew install the_silver_searcher

echo " > Install JetBrains Mono"
brew tap homebrew/cask-fonts
brew cask install font-jetbrains-mono

echo " > Install Amethyst"
brew cask install amethyst

echo " > Install Node"
brew install node

echo " > Install Yarn"
brew install yarn

echo " > Install Ctags"
brew tap universal-ctags/universal-ctags
brew install --HEAD universal-ctags

sudo xcodebuild -license

echo " > Install helper utils"
brew install tree
brew install wget

echo " > Install YouTube-dl"
brew install youtube-dl

echo " > Install ffmpeg"
brew install ffmpeg

echo " > Install poetry"
brew install poetry

echo " > Install postgres"
brew install postgresql
ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
createuser -s postgres

echo " > Install pgcli"
brew install pgcli

echo " > Install bat"
brew install bat

echo " > Install pre-commit"
brew install pre-commit

echo " > Install gettext"
brew install gettext

echo " > Install watson"
brew install watson

echo " > Install redis"
brew install redis
