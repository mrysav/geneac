#!/bin/sh
set -e

QUEUE="*" bundle exec rake resque:work
