#!/bin/bash
set -e

if ! which brew; then
	ruby <(curl -fsSkL raw.github.com/mxcl/homebrew/go)
fi
get="brew install"

$get macvim git svn
easy_install pip
pip install virtualenv
git config --global core.editor "vim"

mv ~/.vim vim.old
mv ~/.vimrc vimrc.old
ln -sf ~/init/vim ~/.vim
ln -sf ~/.vim/.vimrc ~/.vimrc
