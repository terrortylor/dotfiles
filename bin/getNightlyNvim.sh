#!/bin/bash

mv nvim nvim-old
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
# curl -LO https://github.com/neovim/neovim/releases/download/v0.6.1/nvim.appimage
chmod u+x nvim.appimage
mv nvim.appimage nvim
