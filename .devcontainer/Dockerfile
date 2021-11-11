# [Choice] Ruby version: 2, 2.7, 2.6, 2.5
ARG VARIANT=2
FROM mcr.microsoft.com/vscode/devcontainers/ruby:0-${VARIANT}

# Install Rails
RUN gem install rails webdrivers

# Default value to allow debug server to serve content over GitHub Codespaces' port forwarding service
# The value is a comma-separated list of allowed domains
ENV RAILS_DEVELOPMENT_HOSTS=".githubpreview.dev"

# [Choice] Node.js version: lts/*, 16, 14, 12, 10
ARG NODE_VERSION="lts/*"
RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1"

# Install additional OS packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
  && apt-get -y install --no-install-recommends vim tmux imagemagick python3-pip python3-setuptools

# Install python packages
RUN pip3 install mkdocs mkdocs-material cfn-lint

# Install additional gems.
RUN gem install foreman

# Install global node packages.
RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && npm install -g markdownlint-cli" 2>&1

# Install overmind
RUN curl -L https://github.com/DarthSim/overmind/releases/download/v2.2.2/overmind-v2.2.2-linux-amd64.gz > /tmp/overmind.gz \
  && gunzip /tmp/overmind.gz \
  && mv /tmp/overmind /usr/local/bin \
  && chmod +x /usr/local/bin/overmind
