#!/bin/bash

CURRENT_DIR=$PWD

echo "[start]: setup synbolic links"
for DIR in .bashrc .bash_profile .vim .vimrc
do
	echo "unlink synbolic links: $DIR"
	unlink ~/$DIR
done
echo "[completed]: unlink synbolic links"

echo "[start]: setup synbolic links"
for DIR in .zsh .zshrc .zshenv .zprofile .vim .vimrc
do
	echo "set synbolic links: $DIR"
	ln -s $CURRENT_DIR/$DIR ~/$DIR
done
echo "[completed]: link synbolic links"
