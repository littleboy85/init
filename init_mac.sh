#!/bin/bash
set -e

if ! which brew; then
	ruby <(curl -fsSkL raw.github.com/mxcl/homebrew/go)
fi
get="brew install"

$get nvm git wget python ag zsh autojump
pip install --upgrade distribute
pip install --upgrade pip
pip install virtualenv thefuck
git config --global core.editor "nvim"
git config --global user.name "Xiaohan Zhang"
git config --global user.email xiaohan.zhang@me.com

if [ -f ~/.config/nvim/init.vim ]; then
	mv ~/.config/nvim/init.vim init.vim.old
fi
if [ -f ~/.zshrc ]; then
	mv ~/.zshrc zshrc.old
fi
ln -sf ~/vimrc ~/.config/nvim/init.vim
ln -sf ~/init/zshrc ~/.zshrc
