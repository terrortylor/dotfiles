export PATH=${HOME}/.my-bin/nvim-macos-arm64/bin:${PATH}
alias -g vim=nvim
alias -g vims="nvim -S"
alias -g vi=nvim

via() {
  nvim $(git ls-files --modified --others --exclude-standard) $@
}
