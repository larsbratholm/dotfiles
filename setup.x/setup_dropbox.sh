#!/bin/bash

# Download deb package
wget -O $HOME/opt/dropbox.deb https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2024.04.17_amd64.deb

# Install dropbox
sudo apt install -y $HOME/opt/dropbox.deb

# Remove installation file
rm $HOME/opt/dropbox.deb

# Dropbox control script
wget -O $HOME/bin/dropbox https://www.dropbox.com/download?dl=packages/dropbox.py
chmod +x $HOME/bin/dropbox
$HOME/bin/dropbox autostart y
