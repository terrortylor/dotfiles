#! /bin/bash
# From: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux

if command -v terraform &> /dev/null; then
    echo "terraform command found, skipping"
    exit
fi

cd /tmp
wget https://releases.hashicorp.com/terraform/1.1.9/terraform_1.1.9_linux_amd64.zip
unzip terraform_1.1.9_linux_amd64.zip
sudo install -o root -g root -m 0755 terraform /usr/local/bin/terraform
