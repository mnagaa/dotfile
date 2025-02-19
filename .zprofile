#======================================
# setting path
export PATH="$PATH:/opt/homebrew/bin/"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.nodebrew/current/bin"

# setup nodeenv
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init - --no-rehash)"

# java
export JAVA_HOME=`/usr/libexec/java_home -v 11`
export PATH="$PATH:${JAVA_HOME}/bin"
