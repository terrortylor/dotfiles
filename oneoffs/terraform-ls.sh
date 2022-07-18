#! /bin/bash

set -e

pushd /tmp > /dev/null
IS_UPTO_DATE=false
VERSION=$(curl -sL https://api.github.com/repos/hashicorp/terraform-ls/releases/latest | jq -r ".tag_name")
TRIMMED_VERSION="${VERSION##v}" # strip v from front of version

if command -v terraform-ls &> /dev/null; then
  EXISTING_VERSION=$(terraform-ls --version)
  if [ "${EXISTING_VERSION}" != "${TRIMMED_VERSION}" ]; then
    mv /usr/local/bin/terraform-ls "/usr/local/bin/terraform-ls-${EXISTING_VERSION}"
  else
    echo "Version is upto data: ${TRIMMED_VERSION}"
    IS_UPTO_DATE=true
  fi
fi

if ! ${IS_UPTO_DATE}; then
  echo "Downloading version: $VERSION"
  wget "https://github.com/hashicorp/terraform-ls/releases/download/${VERSION}/terraform-ls_${TRIMMED_VERSION}_linux_amd64.zip"

  unzip "terraform-ls_${TRIMMED_VERSION}_linux_amd64.zip"

  sudo mv terraform-ls /usr/local/bin/.
fi
popd > /dev/null
