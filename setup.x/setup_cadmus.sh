#!/bin/bash

# Download deb package
wget -O $HOME/opt/cadmus.deb https://github.com/josh-richardson/cadmus/releases/download/0.0.3/cadmus.deb

# Install zoom
sudo apt install -y $HOME/opt/cadmus.deb

# Remove installation file
rm $HOME/opt/cadmus.deb
