#!/bin/bash

# Download deb package
wget -O $HOME/opt/gitkraken.deb https://release.gitkraken.com/linux/gitkraken-amd64.deb

# Install dropbox
sudo apt install -y $HOME/opt/gitkraken.deb

# Remove installation file
rm $HOME/opt/gitkraken.deb
