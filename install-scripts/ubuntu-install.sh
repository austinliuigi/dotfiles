#!/usr/bin/env bash

# Install Commands
sudo apt install curl
sudo apt install git
sudo apt install imagemagick
sudo apt install make
sudo apt install ncdu
sudo apt install nodejs
sudo apt install npm
sudo apt install stow
curl -sSL https://get.haskellstack.org/ | sh

# Install Zsh (shell)
sudo apt install zsh

# Install dotfiles (config)
git clone --recurse-submodules https://austinliuigi/dotfiles ~/dotfiles

# Install Chrome (web browser)
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

# Install Kitty (tty)
  # Execute install script
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
  # Create link to binary somewhere in PATH
ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/
  # Place the kitty.desktop file somewhere it can be found by the OS
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
  # If you want to open text files and images in kitty via your file manager also add the kitty-open.desktop file
cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
  # Update the paths to kitty and its icon in the kitty.desktop file(s)
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop

# Install Vim (editor)
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudo apt install vim

# Install Neovim (editor)
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install neovim

# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.local/.fzf && bash ~/.local/.fzf/install

# Install lsd

# Install Kmonad
git clone https://github.com/kmonad/kmonad.git ~/.local/kmonad
cd ~/.local/kmonad
stack install

# Install bspwm (window manager)
sudo apt install bspwm

# Install sxhkd (hotkey daemon)
sudo apt install sxhkd

# Install polybar (status bar)
sudo apt install polybar

# Install rofi (application manager)
sudo apt install rofi

# Install picom (compositor)

# Install flameshot (screenshot utility)


# Install nitrogen (wallpaper utility)
sudo apt install nitrogen

# Install fonts
install-fonts() {
	local font_directory="/usr/local/share/fonts/"
	  # Mononoki
	curl -fLo "${font_directory}Mononoki Regular Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Mononoki/Regular/complete/mononoki-Regular%20Nerd%20Font%20Complete.ttf
	curl -fLo "${font_directory}Mononoki Bold Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Mononoki/Bold/complete/mononoki%20Bold%20Nerd%20Font%20Complete.ttf
	curl -fLo "${font_directory}Mononoki Italic Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Mononoki/Italic/complete/mononoki%20Italic%20Nerd%20Font%20Complete.ttf
	curl -fLo "${font_directory}Mononoki Bold-Italic Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Mononoki/Bold-Italic/complete/mononoki%20Bold%20Italic%20Nerd%20Font%20Complete.ttf

	  # Hack
	curl -fLo "${font_directory}Hack Regular Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf
	curl -fLo "${font_directory}Hack Bold Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Bold/complete/Hack%20Bold%20Nerd%20Font%20Complete.ttf
	curl -fLo "${font_directory}Hack Italic Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Italic/complete/Hack%20Italic%20Nerd%20Font%20Complete.ttf
	curl -fLo "${font_directory}Hack Bold-Italic Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/BoldItalic/complete/Hack%20Bold%20Italic%20Nerd%20Font%20Complete.ttf
}
install-fonts
