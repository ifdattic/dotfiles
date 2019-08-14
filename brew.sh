#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew's installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install some other useful utilities like `sponge`.
brew install moreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils

# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names

# Install Bash 4.
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before
# running `chsh`.
brew install bash
brew install bash-completion

# Switch to using brew-installed bash as default shell
if ! fgrep -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
  chsh -s "${BREW_PREFIX}/bin/bash";
fi;

# Install `wget` with IRI support.
brew install wget --with-iri

# Install more recent versions of some OS X tools.
brew install vim --with-override-system-vi
brew install grep
brew install screen

# Install development tools
# brew install angular-cli # needs node
brew install ansible
brew install awscli
# brew install heroku-toolbelt # needs node
brew install git-extras
brew install nvm
brew install s3cmd

# Install other useful binaries.
brew install ack
brew install autojump
brew install git
brew install git-lfs
brew install httpie
brew install ncdu # for calculating disk usage
brew install tree
brew install vbindiff

# Install cask applications
brew cask install android-file-transfer
brew cask install bartender
brew cask install cyberduck
brew cask install licecap
brew cask install mou
brew cask install phpstorm
brew cask install sequel-pro
brew cask install vagrant
brew cask install virtualbox
brew cask install visual-studio-code
brew cask install ynab
brew cask install zoomus

# Remove outdated versions from the cellar.
brew cleanup
