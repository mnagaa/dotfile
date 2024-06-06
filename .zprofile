#======================================
# setting path
export PATH="$PATH:/opt/homebrew/bin/"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.nodebrew/current/bin"

# docker with lima
# https://zenn.dev/matsukaz/articles/31bc31ff1c54b4
# export DOCKER_HOST=unix://$HOME/.lima/lima/sock/docker.sock

# setup pyenv
export PYENV_ROOT="${HOME}/.pyenv"
export PATH="$PATH:${PYENV_ROOT}/bin"
eval "$(pyenv init --path)"

# python setup
export PYTHONPATH="$PWD:$PYTHONPATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# setup nodeenv
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init - --no-rehash)"

# java
export JAVA_HOME=`/usr/libexec/java_home -v 11`
export PATH="$PATH:${JAVA_HOME}/bin"

# added by Snowflake SnowSQL installer v1.2
export PATH=/Applications/SnowSQL.app/Contents/MacOS:$PATH

# Setting PATH for Python 3.12
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.12/bin:${PATH}"
export PATH
