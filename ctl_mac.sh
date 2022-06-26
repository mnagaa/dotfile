#!/bin/zsh

DOTFILE_DIR=~/dotfile

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "[ start ]: installing brew package"
brew bundle
echo "[ completed ]: installing brew package"

ZSH_DIR=$DOTFILE_DIR/.zsh

if [ ! -d $ZSH_DIR ]; then
	mkdir $ZSH_DIR
	cd $ZSH_DIR
	curl -o git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
	curl -o git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
	curl -o _git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
fi

# setup synbolic links
bash cmd/setup_synbolic_links.sh $DOTFILE_DIR

# vim
if [ ! -d molokai ]; then
	git clone https://github.com/tomasr/molokai
	mv molokai/colors/molokai.vim ~/.vim/colors/
else
	echo "Install molokai is skipped."
fi

# node
if [ ! -d ~/.nodenv ]; then
	git clone git://github.com/nodenv/nodenv.git
else
	echo "Install nodeenv is skipped."
fi

