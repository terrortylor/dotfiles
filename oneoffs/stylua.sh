#! /bin/bash

set -e

pushd /tmp > /dev/null || exit
IS_UPTO_DATE=false
VERSION=$(curl -sL https://api.github.com/repos/JohnnyMorganz/StyLua/releases/latest | jq -r ".tag_name")
TRIMMED_VERSION="${VERSION##v}" # strip v from front of version

if command -v stylua &> /dev/null; then
  EXISTING_VERSION=$(stylua --version)
  if [ "${EXISTING_VERSION}" == "stylua ${TRIMMED_VERSION}" ]; then
    echo "Version is upto data: ${TRIMMED_VERSION}"
    IS_UPTO_DATE=true
  fi
fi

if ! ${IS_UPTO_DATE}; then
  echo "Downloading version: $VERSION"
  wget "https://github.com/JohnnyMorganz/StyLua/releases/download/${VERSION}/stylua-linux.zip"

  unzip "stylua-linux.zip"

  sudo mv stylua /usr/local/bin/.
fi
popd > /dev/null || exit
