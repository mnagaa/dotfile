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

brew install --cask \
  visual-studio-code \
  docker \
  zoom

echo "*** finish brew_install.sh *** "
