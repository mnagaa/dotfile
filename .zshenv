#--------------------------------------------------------------#
##          Environment Variables                             ##
#--------------------------------------------------------------#

export ZDOTDIR=$HOME
export ZHOMEDIR=$ZDOTDIR/.zsh
export ZRCDIR=$ZHOMEDIR/rc
export XDG_CONFIG_HOME=$HOME/.config

# aquaのグローバル設定
# これを設定しないと、aqua.yaml のあるディレクトリ以外では aqua 管理のツールが
# "command is not found" になる（~/.config/aqua/aqua.yaml は自動では読まれない）
if [ -f "$XDG_CONFIG_HOME/aqua/aqua.yaml" ]; then
  export AQUA_GLOBAL_CONFIG="$XDG_CONFIG_HOME/aqua/aqua.yaml"
fi

typeset -fuz zkbd
typeset -U path PATH manpath sudo_path
typeset -xT SUDO_PATH sudo_path

path=(
    $HOME/.bin(N-/)
    $HOME/bin(N-/)
    $HOME/.bin.local(N-/)
    $HOME/.local/bin(N-/)
    # aquaでインストールしたCLIツール（これが無いと aqua install -a しても使えない）
    ${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin(N-/)
    # nodenvのshims。.zshrc経由の nodenv init は対話シェルでしか走らないため、
    # 非対話シェル（スクリプトやエディタから起動されるshell）でもnodeを使えるようにする
    ${NODENV_ROOT:-$HOME/.nodenv}/shims(N-/)
    $HOME/go/bin(N-/)
    $HOME/.go/bin(N-/)
    $HOME/.yarn/bin(N-/)
    $HOME/.config/yarn/global/node_modules/.bin(N-/)
    $path
)

# zsh関数のサーチパス
fpath=($HOME/.zfunc(N-/)
  $ZHOMEDIR/zfunc(N-/)
  $ZHOMEDIR/completion(N-/)
  /usr/local/share/zsh/site-functions
  /usr/share/zsh/site-functions
  $fpath
)

if SHELL=$(builtin command -v zsh); then
  export SHELL
else
  unset SHELL
fi

if builtin command -v nvim > /dev/null 2>&1; then
  export EDITOR=nvim
else
  export EDITOR=vim
fi
export PAGER=less
export LESS='--no-init -R --shift 4 --LONG-PROMPT --quit-if-one-screen'
if builtin command -v lesspipe.sh > /dev/null 2>&1; then
  export LESSOPEN="|lesspipe.sh %s"
fi

if builtin command -v dircolors > /dev/null 2>&1 && [ -f "$ZHOMEDIR/dircolors" ]; then
  eval $(dircolors "$ZHOMEDIR/dircolors")
  export USER_LS_COLORS=$LS_COLORS
else
  export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
fi

if [ -f "$ZDOTDIR/.zshenv.local" ]; then
  source "$ZDOTDIR/.zshenv.local"
fi
if [ -f "$ZHOMEDIR/.zshenv.local" ]; then
  source "$ZHOMEDIR/.zshenv.local"
fi
