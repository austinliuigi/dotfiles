#!/usr/bin/env bash

# Install homebrew

# Install zsh (M1 Compatible)
brew install zsh
sudo bash -c 'echo /opt/homebrew/bin/zsh >> /etc/shells'
chsh -s /opt/homebrew/bin/zsh

# Install commands
brew install bat
# brew install exa
brew install fd
brew install gawk
brew install imagemagick
brew install lazygit
brew install lsd
brew install neofetch
brew install ncdu
brew install pstree
brew install ripgrep
brew install stow
brew install tldr
brew install tmux
brew install zoxide

# Install casks
brew install --cask arduino
brew install --cask captin
brew install --cask gimp
brew install --cask google-chrome
brew install --cask kitty
brew install --cask macvim
brew install --cask neovide

# Install brew formulae
brew install fzf
brew install go
brew install neovim
brew install node
brew install python
brew install spaceman
brew install yarn

# Install fonts
# https://github.com/Homebrew/homebrew-cask-fonts/tree/master/Casks
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font

# Install dotfiles
git clone github.com/austinliuigi/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow *

# Install kmonad
#follow instructions @ https://github.com/kmonad/kmonad/issues/334

# Install Swish

# Change dock animation speed
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.5

# Change to three finger drag
# Add path to finder


# Install yabai
# follow instructions @ https://github.com/koekeishiya/yabai/wiki 
# brew install jq

# Install skhd
