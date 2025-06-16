#!/bin/bash

VERSION=4.40.133

# Download deb package
wget -O $HOME/opt/slack.deb https://downloads.slack-edge.com/desktop-releases/linux/x64/$VERSION/slack-desktop-$VERSION-amd64.deb

# Install slack
sudo apt install -y $HOME/opt/slack.deb

# Remove installation file
rm $HOME/opt/slack.deb
