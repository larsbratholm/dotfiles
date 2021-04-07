#!/bin/bash

# Download deb package
wget -O $HOME/opt/zoom.deb https://zoom.us/client/latest/zoom_amd64.deb

# Install zoom
apt install -y $HOME/opt/zoom.deb

# Remove installation file
rm $HOME/opt/zoom.deb
