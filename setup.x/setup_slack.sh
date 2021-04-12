#!/bin/bash

# Download deb package
wget -O $HOME/opt/slack.deb https://www.slack.com/repositories/ubuntu/stable/amd64/slackdesktop-latest

# Install slack
sudo apt install -y $HOME/opt/slack.deb

# Remove installation file
rm $HOME/opt/slack.deb
