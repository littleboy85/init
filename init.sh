#!/bin/bash
set -e

get="apt-get install -y"
$get vim-gnome git automake curl wget htop cmake
$get silversearcher-ag
$get python python-dev python-setuptools python-pip python-virtualenv

# git config --global core.editor "vim"
# git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"

# ln -sf ~/init/vim ~/.vim
# ln -sf ~/.vim/.vimrc ~/.vimrc
