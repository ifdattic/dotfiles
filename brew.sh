#!/usr/bin/env bash

# Install command-line tools using Homebrew.

function updatePHP() {
    sed -i -r 's/;?date.timezone.*/date.timezone = UTC/' /usr/local/etc/php/5.6/php.ini
    sed -i -r 's/;?memory_limit.*/memory_limit = 2G/' /usr/local/etc/php/5.6/php.ini
    sed -i -r 's/;?phar.readonly.*/phar.readonly = Off/' /usr/local/etc/php/5.6/php.ini
}

function postUpdatePHP() {
    sed -i -r 's/;?phar.readonly = Off/phar.readonly = On/' /usr/local/etc/php/5.6/php.ini
}

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade --all

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

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
if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

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
brew install git-extras
brew install node
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
brew install webkit2png


# Install cask applications
brew cask install android-file-transfer
brew cask install bartender
brew cask install cyberduck
brew cask install mou
brew cask install phpstorm
brew cask install selfcontrol
brew cask install sequel-pro
brew cask install tunnelbear
brew cask install vagrant
brew cask install virtualbox
brew cask install ynab

# Remove outdated versions from the cellar.
brew cleanup
