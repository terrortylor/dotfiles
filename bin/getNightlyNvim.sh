#!/bin/bash

# mv nvim nvim-old
# curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
# chmod u+x nvim.appimage
# mv nvim.appimage nvim
mv nvim-macos nvim-macos-old
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz
xattr -c ./nvim-macos.tar.gz
tar xzvf nvim-macos.tar.gz
rm nvim-macos.tar.gz
