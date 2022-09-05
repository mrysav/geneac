#!/bin/sh
set -e

bundle exec rails server --port "$PORT" --binding 0.0.0.0
