#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
pushd "${SCRIPT_DIR}" > /dev/null || exit

# shellcheck source=./scripts/common.sh
source ../scripts/common.sh

info "Arming SUDO"
sudo su -c ""

info "General workflow packages"
add_package tree
add_package fzf
add_package jq
add_package bat
add_package tmux
add_package xclip
add_package slack
add_package google-chrome-stable
add_package ripgrep
add_package azure-cli
add_package lastpass-cli
# shell/bash lsp server
add_package shellcheck
# CIDR calculator
add_package sipcalc
# yamllint schema files
add_package yamllint

popd > /dev/null || exit
