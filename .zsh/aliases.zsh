# ==========================================
# エイリアス設定
# ==========================================

set_base_alias () {
  alias c='clear'
  alias ls='ls -G'
  alias ll='ls -alF'
  alias gip='curl ifconfig.io'
  alias relogin='exec $SHELL -l'
  alias watch='watch -c'
}

set_git_alias () {
	alias g='git'
	alias ga='git add'
  alias grs='git restore --staged $(echo $(git diff --name-only --cached) | awk -v ORS=" " 1)' # unstaged all files
	alias gr='git rebase'
	alias gri='git rebase -i'
	alias gd='git diff'
	alias gp='git push'
	alias gpl='git pull'
	alias gb='git branch'
	alias gsw='git switch'
	alias gst='git status'
	alias gco='git checkout'
	alias gf='git fetch'
	alias gc='git commit -v'
  alias ggraph='git log --graph --oneline'
  alias wgraph='watch git log --graph --oneline'
  alias wgst='watch git status'
  alias gpu='git push --set-upstream origin $(git branch --show-current)'
}

set_base_alias
set_git_alias

# change ls color
export CLICOLOR=1
export LSCOLORS=HeFxCxDxBxegedabagaced

