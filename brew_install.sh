#!/bin/bash

echo "*** start brew_install.sh *** "
brew list -1

brew install \
  tree \
  wget \
  yarn \
  nodebrew\
  jq \
  watch

for fname in visual-studio-code docker zoom iterm2; do
	brew install --cask $fname
done

echo "*** finish brew_install.sh *** "
