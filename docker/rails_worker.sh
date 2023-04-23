#!/bin/sh
set -e

bundle exec sidekiq -q default -q mailers
