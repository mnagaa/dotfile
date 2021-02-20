#!/bin/sh

DIR=~/dotfile/.zsh
if [ ! -d $DIR ];then
	mkdir $DIR
	cd $DIR
	curl -o git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
	curl -o git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
	curl -o _git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
fi

ln -s ~/dotfile/.zsh ~/.zsh
ln -s ~/dotfile/.zshrc ~/.zshrc
ln -s ~/dotfile/.zshenv ~/.zshenv
ln -s ~/dotfile/.zprofile ~/.zprofile
ln -s ~/dotfile/.vimrc ~/.vimrc
