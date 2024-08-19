#!/bin/bash

set -euo pipefail

docker compose up -d --wait

echo -e "Creating database user..."
psql postgres://postgres:postgres@localhost:5432/ < script/create-db-user.sql

echo -e "Installing dependencies..."

bundle install
yarn install

echo -e "Setting up database and test users..."
rake db:create db:schema:load
rails generate:test:accounts

echo -e "\n============================================="
echo -e "Congratulations! The environment is good to go."
echo -e "You can start the development server with:\n  overmind start -f Procfile.dev"
echo -e "and then you can log in with the email 'mcfly@bttf.net' and password 'thatsheavy'"
