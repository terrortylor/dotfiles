#! /bin/bash

set -e

pushd /tmp > /dev/null
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
popd > /dev/null
