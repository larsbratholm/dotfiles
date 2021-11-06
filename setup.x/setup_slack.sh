#!/bin/bash

# Download deb package
wget -O $HOME/opt/slack.deb https://downloads.slack-edge.com/releases/linux/4.21.1/prod/x64/slack-desktop-4.21.1-amd64.deb

# Install slack
sudo apt install -y $HOME/opt/slack.deb

# Remove installation file
rm $HOME/opt/slack.deb
