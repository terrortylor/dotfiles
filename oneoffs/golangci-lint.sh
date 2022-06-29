#! /bin/bash

set -e

VERSION=$(curl -sL https://api.github.com/repos/golangci/golangci-lint/releases/latest | jq -r ".tag_name")
echo "Downloading version: $VERSION"

# binary will be $(go env GOPATH)/bin/golangci-lint
curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b "$(go env GOPATH)/bin" "${VERSION}"

golangci-lint --version
