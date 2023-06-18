ARG VARIANT=3.2
FROM mcr.microsoft.com/vscode/devcontainers/ruby:${VARIANT}

# Default value to allow debug server to serve content over GitHub Codespaces' port forwarding service
# The value is a comma-separated list of allowed domains
ENV RAILS_DEVELOPMENT_HOSTS=".githubpreview.dev"

# [Choice] Node.js version: lts/*, 16, 14, 12, 10
ARG NODE_VERSION="lts/*"
RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} && npm install -g markdownlint-cli 2>&1"

ENV DEBIAN_FRONTEND=noninteractive

# Install additional OS packages.
RUN apt-get update && \
    apt-get -y install --no-install-recommends vim tmux imagemagick \
    python3-pip python3-setuptools libvips42 poppler-utils openssh-server postgresql-client

# Install python packages
RUN pip3 install --break-system-packages cfn-lint

# Install overmind
RUN curl -L https://github.com/DarthSim/overmind/releases/download/v2.3.0/overmind-v2.3.0-linux-amd64.gz > /tmp/overmind.gz \
  && gunzip /tmp/overmind.gz \
  && mv /tmp/overmind /usr/local/bin \
  && chmod +x /usr/local/bin/overmind

# Copy all the files into the container
COPY Gemfile* /tmp/workspace/
COPY docs/Gemfile* /tmp/workspace/docs/
RUN chown -R vscode /tmp/workspace
WORKDIR /tmp/workspace
USER vscode

RUN bundle install && \
    cd docs/ && bundle install && \
    cd /home/vscode && \
    rm -rf /tmp/workspace

# Install additional gems.
RUN gem install foreman

WORKDIR /home/vscode
