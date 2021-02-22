#!/bin/bash

function delete_and_symlink(){
path=$HOME/$1
if [ -e $path ];then
rm -rf $path
ln -s $HOME/dotfile/$1 $path
fi
}

# bash setting
for path in .bashrc .bash_profile; do
    delete_and_symlink $path
done

# vim setting
for path in .vimrc ; do
    delete_and_symlink $path
done
