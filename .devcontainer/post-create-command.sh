#!/bin/bash

echo -e "Installing dependencies..."
bundle install
yarn install

echo -e "Setting up database and test users..."
rake db:create db:schema:load
rails generate:test-accounts

echo -e "\n============================================="
echo -e "Congratulations! The container is good to go."
echo -e "You can start the development server with:\n  overmind start -f Procfile.dev"
echo -e "and then you can log in with the email 'mcfly@bttf.net' and password 'thatsheavy'"
