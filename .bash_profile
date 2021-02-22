# .bash_profile

source ~/.git-prompt.sh
source ~/.git-completion.bash

GIT_PS1_SHOWDIRTYSTATE=true
PS1='\[\e[0;36m\][ \u@\h ]\[\e[0m\] >>\[\e[0;32m\] [ \w ] \[\e[0;33m\][branch$(__git_ps1)] \[\e[1;0m\]\n$ '

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
