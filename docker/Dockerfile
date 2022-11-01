# [Choice] Ruby version: 2, 2.7, 2.6, 2.5
ARG VARIANT=3
FROM ruby:${VARIANT}


RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
  && curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | tee /usr/share/keyrings/yarnkey.gpg >/dev/null \
  && echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && DEBIAN_FRONTEND=noninteractive apt-get update \
  && apt-get install -y --no-install-recommends imagemagick nodejs yarn poppler-utils

# Add things to the docker entrypoint script if you want
COPY docker/docker-entrypoint.sh /usr/bin/
COPY docker/rails_web.sh /usr/bin/
COPY docker/rails_worker.sh /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint.sh
RUN chmod +x /usr/bin/rails_web.sh
RUN chmod +x /usr/bin/rails_worker.sh

RUN useradd -s /bin/bash geneac && mkdir /home/geneac && chown geneac /home/geneac

# Copy all the files into the container
COPY . /app
RUN chown -R geneac /app
WORKDIR /app
USER geneac

RUN bundle config set --local without 'development,test' \
  && bundle install \
  && yarn install \
  && rake assets:precompile \
  && rake assets:clean

ENTRYPOINT ["docker-entrypoint.sh"]
