#!/bin/bash

bundle install
rake db:create db:schema:load
yarn install
