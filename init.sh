#!/bin/bash
set -e

get="sudo apt-get install -y"
$get vim git bzr subversion default-jdk automake curl
$get python python-dev python-setuptools python-pip python-virtualenv
$get libreadline-dev

git config --global core.editor "vim"
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"

mv ~/.vim vim.old
mv ~/.vimrc vimrc.old
ln -sf ~/init/ackrc ~/.ackrc
ln -sf ~/init/vim ~/.vim
ln -sf ~/.vim/.vimrc ~/.vimrc
