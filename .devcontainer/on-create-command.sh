#!/bin/bash

set -euo pipefail

source /usr/local/share/nvm/nvm.sh && nvm install "lts/*" && npm install -g markdownlint-cli 2>&1

# Add Terraform and Azure CLI repositories
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
wget -O- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /usr/share/keyrings/microsoft.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/azure-cli.list

# Install additional OS packages.
sudo apt-get update
export DEBIAN_FRONTEND=noninteractive
sudo apt-get -y install --no-install-recommends imagemagick libvips42 poppler-utils terraform azure-cli postgresql-client

# Install overmind
curl -L https://github.com/DarthSim/overmind/releases/download/v2.4.0/overmind-v2.4.0-linux-amd64.gz > /tmp/overmind.gz
gunzip /tmp/overmind.gz
sudo mv /tmp/overmind /usr/local/bin
sudo chmod +x /usr/local/bin/overmind
