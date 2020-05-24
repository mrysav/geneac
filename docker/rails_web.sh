#!/bin/sh
set -e

bundle exec rake assets:precompile
bundle exec rake assets:clean

bundle exec rails server --port 3000 --binding 0.0.0.0
