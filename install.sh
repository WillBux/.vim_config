#!/bin/zsh
set -e

echo "Installing Buxton's Neovim Configuration"

VIMRC='set runtimepath+=~/.vim_config
\n\nsource ~/.vim_config/plug.vim
\n\nsource ~/.vim_config/config.vim'

# vim plug install
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# write config
echo $VIMRC > ~/.config/nvim/init.vim

# run :PlugInstall
nvim -es -u init.vim -i NONE -c "PlugInstall" -c "qa"

