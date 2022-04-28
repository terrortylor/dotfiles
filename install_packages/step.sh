#! /bin/bash
# From: https://smallstep.com/docs/step-cli/installation

if command -v step &> /dev/null; then
    echo "step command found, skipping"
    exit
fi

wget https://dl.step.sm/gh-release/cli/docs-cli-install/v0.19.0/step-cli_0.19.0_amd64.deb
sudo dpkg -i step-cli_0.19.0_amd64.deb
rm step-cli*.deb
