# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


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
# $ zplug install
if [[ ! -d $HOME/.zplug ]];then
  git clone https://github.com/zplug/zplug $HOME/dotfile/.zplug
  ln -s ~/dotfile/.zplug ~/.zplug
fi
source ~/.zplug/init.zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# theme: https://github.com/unixorn/awesome-zsh-plugins#themes
# theme (https://github.com/sindresorhus/pure#zplug)

zplug "mafredri/zsh-async"

# 構文のハイライト(https://github.com/zsh-users/zsh-syntax-highlighting)
zplug "zsh-users/zsh-syntax-highlighting"
# history関係
zplug "zsh-users/zsh-history-substring-search"
# タイプ補完
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "chrissicool/zsh-256color"


# https://github.com/ryanoasis/nerd-fonts
# brew tap homebrew/cask-fonts
zplug romkatv/powerlevel10k, as:theme, depth:1

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    # if read -q; then
        echo; zplug install
    # fi
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
fh () {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# Setting for Plugin
plugins=(git zsh-syntax-highlighting zsh-autosuggestions zsh-completions)

autoload predict-on
# predict-on
autoload -U compinit && compinit -u

# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'

# share history when opening multi-prompt
setopt share_history
setopt hist_ignore_all_dups  # 重複するコマンドのhistory削除
setopt print_eight_bit  # 日本語ファイル名を表示可能にする
setopt auto_cd  # cdなしでディレクトリ移動
setopt no_beep  # ビープ音の停止
setopt nolistbeep  # ビープ音の停止(補完時)
setopt auto_pushd  # cd -<tab>で以前移動したディレクトリを表示
export LANG=ja_JP.UTF-8  # 文字コードの指定
autoload -Uz colors  # 色を使用出来るようにする

source ~/.zsh/git-prompt.sh  # git-promptの読み込み

# git-completionの読み込み
fpath=(~/.zsh $fpath)
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
autoload -Uz compinit && compinit

# プロンプトのオプション表示設定
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUPSTREAM=auto

# change ls color
export CLICOLOR=1
export LSCOLORS=HeFxCxDxBxegedabagaced

set_base_alias () {
  alias ls='ls -G'
  alias ll='ls -alF'
  alias gip='curl ifconfig.io'
  alias relogin='exec $SHELL -l'
  alias watch='watch -c'

  # snowflake
  alias snowsql=/Applications/SnowSQL.app/Contents/MacOS/snowsql
}

set_git_alias () {
	alias g='git'
	alias ga='git add'
	alias gr='git rebase'
	alias gri='git rebase -i'
	alias gd='git diff'
	alias gp='git push'
	alias gb='git branch'
	alias gsw='git switch'
	alias gst='git status'
	alias gco='git checkout'
	alias gf='git fetch'
	alias gc='git commit'
  alias ggraph='git log --graph --oneline'
  alias wgraph='watch git log --graph --oneline'
  alias wgst='watch git status'
}

set_base_alias
set_git_alias

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

test -e "${ZDOTDIR}/.iterm2_shell_integration.zsh" && source "${ZDOTDIR}/.iterm2_shell_integration.zsh"
