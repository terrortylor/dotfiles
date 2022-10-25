#! /bin/bash

set -e

# shellcheck source=./scripts/common.sh
source ../scripts/common.sh

info "Installing warpd"

pushd /tmp > /dev/null || exit
IS_UPTO_DATE=false
VERSION=$(curl -sL https://api.github.com/repos/rvaiya/warpd/releases/latest | jq -r ".tag_name")

if command -v warpd &> /dev/null; then
  EXISTING_VERSION=$(warpd --version)
  if [[ "${EXISTING_VERSION}" =~ "warpd ${VERSION}" ]]; then
    skip "\twarpd version is upto data: ${VERSION}"
    IS_UPTO_DATE=true
  fi
fi

if ! ${IS_UPTO_DATE}; then
  info "\tDownloading version: $VERSION"
  if [[ $OSTYPE == 'darwin'* ]]; then
    curl -L https://github.com/rvaiya/warpd/releases/download/${VERSION}/warpd-osx.tgz |  sudo tar xzvfC - / && launchctl load /Library/LaunchAgents/com.warpd.warpd.plist
  else
    error "\tNo installer setup for warpd on linux, yet"
  fi
fi
popd > /dev/null || exit
