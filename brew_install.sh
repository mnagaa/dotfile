#!/bin/bash

echo "*** start brew_install.sh *** "
brew list -1

brew install \
  cask \
  git \
  git-secrets \
  tree \
  wget \
  yarn \
  nodebrew\
  pyenv \
  jq \
  python-yq \
  watch \
  htop \
  colordiff \
  nkf \
  telnet \
  truncate \
  sl \
  awscli

for fname in visual-studio-code \
              docker \
              docker-machine \
              zoom \
              iterm2 \
              google-backup-and-sync \
              google-japanese-ime \
              vlc \
              imageoptim \
              ffmpeg \
              keka \
              tunnelblick \
              drawio \
              mysqlworkbench \
              postman \
              proxyman \
              cyberduck \
              clipy
do
	brew install --cask $fname
done

echo "*** finish brew_install.sh *** "

