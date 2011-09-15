#!/bin/bash
set -e

get="apt-get install -y"
$get vim git bzr subversion default-jdk automake curl
$get python python-dev python-setuptools python-pip python-virtualenv
$get libreadline-dev

git config --global core.editor "vim"

ln -sf bashrc ~/.bashrc
ln -sf vim ~/.vim
ln -sf ~/.vim/.vimrc ~/.vimrc
