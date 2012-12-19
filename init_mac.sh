#!/bin/bash
set -e

if ! which brew; then
	ruby <(curl -fsSkL raw.github.com/mxcl/homebrew/go)
fi
get="brew install"

$get macvim git wget python ack
pip install --upgrade distribute
pip install --upgrade pip
pip install virtualenv
git config --global core.editor "vim"
git config --global user.name "Xiaohan Zhang"
git config --global user.email xiaohan.zhang@me.com

mv ~/.vim vim.old
mv ~/.vimrc vimrc.old
mv ~/.bashrc bashrc.old
mv ~/.bash_profile bash_profile.old
ln -sf ~/init/vim ~/.vim
ln -sf ~/.vim/.vimrc ~/.vimrc
ln -sf ~/init/bashrc_mac ~/.bashrc
ln -sf ~/init/bash_profile ~/.bash_profile
ln -sf ~/init/shortcut.sh ~/.shortcut.sh
