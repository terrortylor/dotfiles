#! /bin/bash

source ../scripts/common.sh

packages=""

add_package() {
  # packages="${packages} ${1}"
  OUTPUT="$(mktemp)"
  sudo apt-get --assume-yes install "${1}" &> $OUTPUT
  if [ $? -ne 0 ]; then
    fail "Installing: ${1}"
    cat $OUTPUT
    exit 1
  fi
  success "Installing: ${1}"
  rm $OUTPUT
}

info "Arming SUDO"
sudo su -c ""

info "General workflow packages"
add_package fzf
add_package tmux
add_package slack
add_package google-chrome-stable
add_package ripgrep
add_package azure-cli

