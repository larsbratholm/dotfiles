#!/bin/bash

curl -s https://api.github.com/repos/neovim/neovim/releases/latest \
| grep "browser_download_url.*nvim-linux-x86_64.appimage" \
| grep -v "zsync" \
| cut -d '"' -f 4 \
| xargs wget -O ~/bin/nvim.appimage
chmod +x ~/bin/nvim.appimage
