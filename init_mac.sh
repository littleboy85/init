#!/bin/bash
set -e

if ! which brew; then
	ruby <(curl -fsSkL raw.github.com/mxcl/homebrew/go)
fi
get="brew install"

$get git wget python python3 ag zsh autojump watchman
pip install --upgrade distribute
pip install --upgrade pip
pip install virtualenv thefuck
git config --global core.editor "nvim"
git config --global user.name "Xiaohan Zhang"
git config --global user.email xiaohan.zhang.xz@gmail.com

if [ -f ~/.config/nvim/init.vim ]; then
	mv ~/.config/nvim/init.vim init.vim.old
fi
if [ -f ~/.zshrc ]; then
	mv ~/.zshrc zshrc.old
fi
mkdir -p ~/.config
ln -sf ~/init/vim ~/.vim
ln -sf ~/init/vim/.vimrc ~/.vimrc
ln -sf ~/init/vim/.vimrc ~/init/vim/init.vim
ln -sf ~/.vim ~/.config/nvim
ln -sf ~/init/zshrc ~/.zshrc
sudo sh -c "echo '/usr/local/bin/zsh' >> /etc/shells"
chsh -s $(which zsh)
