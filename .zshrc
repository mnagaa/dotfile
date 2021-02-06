
#======================================
# setting path

export PATH="$HOME/.cargo/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# ==========================================
# 1) .zshenv
# 2) .zprofile
# 3) .zshrc  *** this file
# 4) .zlogin
#
# $ zcompile ~/.zshrc
# でコンパイルしておくと読み込むときに時間がかからなくなるので
# scriptが長くなったときに実行する
# ==========================================
# zplugが無ければインストール
if [[ ! -d $HOME/.zplug ]];then
  git clone https://github.com/zplug/zplug $HOME/dotfile/.zplug
  ln -s ~/dotfile/.zplug ~/.zplug
fi
# $ zplug install
# zplug
source ~/.zplug/init.zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# theme (https://github.com/sindresorhus/pure#zplug)　好みのスキーマをいれてくだされ。

# zplug "mafredri/zsh-async"
# zplug "sindresorhus/pure"

# 構文のハイライト(https://github.com/zsh-users/zsh-syntax-highlighting)
zplug "zsh-users/zsh-syntax-highlighting"
# history関係
zplug "zsh-users/zsh-history-substring-search"
# タイプ補完
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "chrissicool/zsh-256color"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
# Then, source plugins and add commands to $PATH
zplug load

if [[ ! -d $HOME/dotfile/.fzf ]];then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/dotfile/.fzf
  ln -s ~/dotfile/.fzf ~/.fzf
  ~/.fzf/install
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
# fh - repeat history
fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}
# ===================================
# Setting for Plugin
# ===================================
plugins=(git zsh-syntax-highlighting zsh-autosuggestions zsh-completions)

autoload predict-on
# predict-on
autoload -U compinit && compinit -u

# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'

# share history when opening multi-prompt
setopt share_history
# 重複するコマンドのhistory削除
setopt hist_ignore_all_dups
# 日本語ファイル名を表示可能にする
setopt print_eight_bit
# cdなしでディレクトリ移動
setopt auto_cd
# ビープ音の停止
setopt no_beep
# ビープ音の停止(補完時)
setopt nolistbeep
# cd -<tab>で以前移動したディレクトリを表示
setopt auto_pushd
# 文字コードの指定
export LANG=ja_JP.UTF-8
# 色を使用出来るようにする
autoload -Uz colors
colors
# promptの左と右に表示させる
PROMPT='%F{magenta}%B%n%b%f@%F{blue}%U%m%u%f %# '
RPROMPT='%F{green}[%~]%f'


# IF anaconda is built on pyenv, conda setting can be done with below.
# Something wrong with your conda environment, you should input 'conda init'
# on your terminal.
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/masa/.pyenv/versions/anaconda3-2019.10/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/masa/.pyenv/versions/anaconda3-2019.10/etc/profile.d/conda.sh" ]; then
        . "/Users/masa/.pyenv/versions/anaconda3-2019.10/etc/profile.d/conda.sh"
    else
        export PATH="/Users/masa/.pyenv/versions/anaconda3-2019.10/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"
if which plenv > /dev/null; then eval "$(plenv init - zsh)"; fi



alias ls='ls -G'
alias ll='ls -alF'
alias g='git'
alias ga='git add'
alias gd='git diff'
alias gs='git status'
alias gp='git push'
alias gb='git branch'
alias gst='git status'
alias gco='git checkout'
alias gf='git fetch'
alias gc='git commit'

PATH="/Users/mnaga/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/mnaga/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/mnaga/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/mnaga/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/mnaga/perl5"; export PERL_MM_OPT;
