#!/bin/bash
set -e

get="sudo apt-get install -y"
$get vim git bzr subversion default-jdk automake curl
$get python python-dev python-setuptools python-pip python-virtualenv
$get libreadline-dev

git config --global core.editor "vim"

mv ~/.vim vim.old
mv ~/.vimrc vimrc.old
ln -sf ~/init/vim ~/.vim
ln -sf ~/.vim/.vimrc ~/.vimrc
