#!/bin/bash

# Download deb package
wget -O $HOME/opt/dropbox.deb https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2020.03.04_amd64.deb

# Install dropbox
apt install -y $HOME/opt/dropbox.deb

# Remove installation file
rm $HOME/opt/dropbox.deb

# Dropbox control script
wget -o $HOME/bin/dropbox https://www.dropbox.com/download?dl=packages/dropbox.py
