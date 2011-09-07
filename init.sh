#!/bin/bash
set -e

get="apt-get install -y"
$get vim git bzr subversion default-jdk automake
$get python python-dev python-setuptools python-pip python-virtualenv
$get libreadline-dev

git config --global core.editor "vim"

cp bashrc ~/.bashrc
if [ ! -e ~/.vim ]; then
    mkdir ~/.vim
    cp -r vim/* ~/.vim/
fi

if [ ! -e ~/.vim/plugin/NERD_tree.vim ]; then
    git clone https://github.com/scrooloose/nerdtree.git
    cp -r nerdtree/doc ~/.vim/
    cp -r nerdtree/plugin ~/.vim/
    cp -r nerdtree/nerdtree_plugin ~/.vim/
    rm -rf nerdtree
fi

