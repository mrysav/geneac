FROM ruby:2.7.1

RUN apt-get update -qq && apt-get install -y build-essential

# for postgres
RUN apt-get install -y libpq-dev

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# for a JS runtime
RUN apt-get install -y nodejs npm
RUN npm install -g yarn

ENV APP_HOME /geneac
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install

ADD package.json $APP_HOME/
ADD yarn.lock $APP_HOME/
RUN yarn install

# Add things to the docker entrypoint script if you want
COPY docker-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

ADD . $APP_HOME
