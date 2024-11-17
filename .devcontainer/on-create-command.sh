#!/bin/bash

set -euo pipefail

source /usr/local/share/nvm/nvm.sh && nvm install "lts/*" && npm install -g markdownlint-cli 2>&1

# Install additional OS packages.
sudo apt-get update
export DEBIAN_FRONTEND=noninteractive
sudo apt-get -y install --no-install-recommends imagemagick libvips42 poppler-utils sqlite3 tmux

# Install overmind
curl -L https://github.com/DarthSim/overmind/releases/download/v2.5.1/overmind-v2.5.1-linux-amd64.gz > /tmp/overmind.gz
gunzip /tmp/overmind.gz
sudo mv /tmp/overmind /usr/local/bin
sudo chmod +x /usr/local/bin/overmind
