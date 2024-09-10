mac-setting:
	bash ctl_mac.sh

linux-setting:
	bash ctl_linux.sh

# Install from Brewfile
brew-install:
	brew bundle

# Dump to Brewfile
brew-dump:
	brew bundle dump
