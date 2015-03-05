#!/usr/bin/env bash

# Install python related tools

# Ask for the administrator password upfront.
sudo -v

# Install pip package manager
sudo easy_install pip

# Install EB CLI
sudo pip install awsebcli

# Install Docker Compose
sudo pip install -U docker-compose
