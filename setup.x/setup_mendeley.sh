#!/bin/bash

# Download deb package
wget -O $HOME/opt/mendeley.deb https://www.mendeley.com/repositories/ubuntu/stable/amd64/mendeleydesktop-latest

# Install mendeley
apt install -y $HOME/opt/mendeley.deb

# Remove installation file
rm $HOME/opt/mendeley.deb
