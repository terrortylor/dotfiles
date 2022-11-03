#! /bin/bash

set -e

pushd /tmp > /dev/null || exit
IS_UPTO_DATE=false
VERSION=$(curl -sL https://api.github.com/repos/hashicorp/terraform-ls/releases/latest | jq -r ".tag_name")
TRIMMED_VERSION="${VERSION##v}" # strip v from front of version

if [[ $OSTYPE == 'darwin'* ]]; then
  suffix="darwin_arm64"
else
  suffix="linux_amd64"
fi

if command -v terraform-ls &> /dev/null; then
  EXISTING_VERSION=$(terraform-ls --version)
  if [ "${EXISTING_VERSION}" != "${TRIMMED_VERSION}" ]; then
    sudo mv /usr/local/bin/terraform-ls "/usr/local/bin/terraform-ls-${EXISTING_VERSION}"
  else
    echo "Version is upto data: ${TRIMMED_VERSION}"
    IS_UPTO_DATE=true
  fi
fi

if ! ${IS_UPTO_DATE}; then
  echo "Downloading version: $VERSION"
  wget "https://github.com/hashicorp/terraform-ls/releases/download/${VERSION}/terraform-ls_${TRIMMED_VERSION}_${suffix}.zip"
  sudo mkdir -p /usr/local/bin

  unzip "terraform-ls_${TRIMMED_VERSION}_${suffix}.zip"

  sudo mv terraform-ls /usr/local/bin/.
fi
popd > /dev/null || exit
