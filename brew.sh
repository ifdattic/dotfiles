#!/usr/bin/env bash

# Install command-line tools using Homebrew.

function updatePHP() {
    sed -i -r 's/;?date.timezone.*/date.timezone = UTC/' /usr/local/etc/php/5.6/php.ini
    sed -i -r 's/;?phar.readonly.*/phar.readonly = Off/' /usr/local/etc/php/5.6/php.ini
}

function postUpdatePHP() {
    sed -i -r 's/;?phar.readonly = Off/phar.readonly = On/' /usr/local/etc/php/5.6/php.ini
}

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade --all

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

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

# Install `wget` with IRI support.
brew install wget --with-iri

# Install more recent versions of some OS X tools.
brew install vim --override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/screen

# Update PHP
brew tap homebrew/dupes
brew install homebrew/php/php56

updatePHP

brew install homebrew/php/php-cs-fixer
brew install homebrew/php/php-code-sniffer
brew install homebrew/php/phpmd
brew install homebrew/php/composer
brew install homebrew/php/php56-mongo

postUpdatePHP

# Install development tools
brew install awscli
brew install ansible
brew install heroku-toolbelt

# Install other useful binaries.
brew install ack
brew install httpie

brew install git
brew install tree
brew install webkit2png

brew install autojump

# Install Node.js. Note: this installs `npm` too, using the recommended
# installation method.
brew install node

# Install cask applications
brew cask install android-file-transfer
brew cask install licecap
brew cask install selfcontrol
brew cask install virtualbox

# Remove outdated versions from the cellar.
brew cleanup
