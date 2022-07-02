#!/bin/zsh

DOTFILE_DIR=$PWD

setup_synbolic_link(){
	echo "  unlink synbolic links: $1"
	unlink ~/$1
	echo "  set synbolic links: $1"
	ln -s $DOTFILE_DIR/$1 ~/$1
}

cd $DOTFILE_DIR

echo "[ start ]: setup synbolic links for zsh"
setup_synbolic_link .zsh
setup_synbolic_link .zshrc
setup_synbolic_link .zshenv
setup_synbolic_link .zprofile
setup_synbolic_link .p10k.zsh
echo "[ completed ]: setup synbolic links for zsh"

echo "[ start ]: setup synbolic links for git"
setup_synbolic_link .gitconfig
echo "[ completed ]: setup synbolic links for git"

echo "[ start ]: setup synbolic links for vim"
setup_synbolic_link .vim
setup_synbolic_link .vimrc
ln -s "$HOME/.vimrc" "$HOME/.ideavimrc"
echo "[ completed ]: setup synbolic links for vim"

echo "[ start ]: setup synbolic links for iterm2"
setup_synbolic_link .iterm2_shell_integration.zsh
echo "[ completed ]: unlink symbolic links"

