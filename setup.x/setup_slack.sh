#!/bin/bash

# Download deb package
wget -O $HOME/opt/slack.deb https://downloads.slack-edge.com/linux_releases/slack-desktop-4.14.0-amd64.deb

# Install slack
sudo apt install -y $HOME/opt/slack.deb

# Remove installation file
rm $HOME/opt/slack.deb
