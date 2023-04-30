# [Choice] Ruby version: 2, 2.7, 2.6, 2.5
ARG VARIANT=3

FROM ruby:${VARIANT} AS base

# Install NodeJS and any likely dependencies for the Ruby packages to build
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
  && apt-get install -y --no-install-recommends imagemagick poppler-utils libvips42 postgresql-client

COPY . /app
WORKDIR /app

RUN bundle config set --local without 'development,test' \
  && bundle install

FROM base AS asset-builder

# Install NodeJS and any likely dependencies for the Ruby packages to build
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
  && curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | tee /usr/share/keyrings/yarnkey.gpg >/dev/null \
  && echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && DEBIAN_FRONTEND=noninteractive apt-get update \
  && apt-get install -y --no-install-recommends nodejs yarn

RUN yarn install \
  && rake assets:precompile \
  && rake assets:clean

FROM base AS production

# Add things to the docker entrypoint script if you want
COPY docker/docker-entrypoint.sh /usr/bin/
COPY docker/rails_web.sh /usr/bin/
COPY docker/rails_worker.sh /usr/bin/

RUN chmod +x /usr/bin/docker-entrypoint.sh \
  && chmod +x /usr/bin/rails_web.sh \
  && chmod +x /usr/bin/rails_worker.sh

RUN useradd -s /bin/bash geneac && mkdir /home/geneac && chown geneac /home/geneac

# Copy assets built in the asset-builder stage on over here
COPY --from=asset-builder /app/public /app/public

RUN chown -R geneac /app
USER geneac

ENTRYPOINT ["docker-entrypoint.sh"]
