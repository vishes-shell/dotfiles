#!/usr/bin/env bash

if [ "$(uname -s)" != "Darwin" ]; then
	exit 0
fi

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
