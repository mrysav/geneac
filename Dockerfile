FROM ruby:2.7.3-alpine

# includes support for postgres, nokogiri, and a js runtime
# then installs yarn with npm

RUN apk add --update --no-cache build-base yarn git nodejs imagemagick tzdata postgresql-dev libxml2-dev libxslt-dev

ENV APP_HOME /geneac
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Add things to the docker entrypoint script if you want
COPY docker-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

ADD Gemfile* $APP_HOME/
RUN bundle install

ADD package.json $APP_HOME/
ADD yarn.lock $APP_HOME/
RUN yarn install

ADD . $APP_HOME
