# Map vi[m] to nvim
alias vim=nvim
alias vi=nvim
alias clearvimswap="rm -rf ~/.local/share/nvim/swap"

function vimmm() {
  cd ~/personal-workspace/vim-environment
  ls

  vim lua/config/plugins.lua
}
