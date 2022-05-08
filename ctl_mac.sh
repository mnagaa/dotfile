#!/bin/zsh

CURRENT_DIR=$PWD
ZSH_DIR=$CURRENT_DIR/.zsh

if [ ! -d $ZSH_DIR ];then
	mkdir $ZSH_DIR
	cd $ZSH_DIR
	curl -o git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
	curl -o git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
	curl -o _git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
fi

cd $CURRENT_DIR

echo "[start]: setup synbolic links"
for DIR in .zsh .zshrc .zshenv .zprofile .vim .vimrc .p10k.zsh
do
	echo "    unlink synbolic links: $DIR"
	unlink ~/$DIR
done
echo "[completed]: unlink synbolic links"

echo "[start]: setup synbolic links"
for DIR in .zsh .zshrc .zshenv .zprofile .vim .vimrc .p10k.zsh
do
	echo "    set synbolic links: $DIR"
	ln -s $CURRENT_DIR/$DIR ~/$DIR
done
echo "[completed]: link synbolic links"


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
