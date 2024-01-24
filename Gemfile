# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.3"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 7.1.0"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.5"

# Use Puma as the app server
gem "puma", "~> 6.4"

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "jsbundling-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

gem "redis", ">= 5.0"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem "bcrypt", "~> 3.1.19"

# Use ActiveStorage variant
gem "image_processing", "~> 1.12"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[mri windows]

  gem "database_cleaner-active_record"
  gem "factory_bot_rails"
  gem "rails-controller-testing"
  gem "rspec-rails", "~> 6.1.0"
  gem "timecop"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "web-console", ">= 4.1.0"
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  # gem 'rack-mini-profiler', '~> 2.0'
  gem "listen", "~> 3.8"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring", ">= 3.0.0"

  # Linters and other tools
  gem "erb_lint", require: false
  gem "haml_lint", require: false
  gem "rubocop", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rake", require: false
  gem "rubocop-rspec", require: false
  gem "ruby-lsp", require: false
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  # gem "capybara", ">= 3.26"
  # gem "selenium-webdriver"
  # Easy installation and use of web drivers to run system tests with browsers
  # gem "webdrivers"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

# Workin' jobs
gem "resque"

# For generating fake data - used in a rake task as well as tests
gem "faker"

# Use Devise for authentication
gem "devise", "~> 4.9"

# Pundit for policies
gem "pundit"

# simple_form and country_select for easier forms
gem "country_select"
gem "simple_form", "~> 5.2"

# administrate for content management
gem "administrate", "~> 0.19" #github: "mrysav/administrate", branch: "main"
# administrate plugins
gem "administrate-field-nested_has_many"
# administrate-field-nested_has_many has an undeclared hard dependency on sassc
gem "sassc-rails"

# For content tagging
gem "acts-as-taggable-on", "~> 10.0"

group :production do
  # For azure
  gem "azure-storage-blob", "~> 2.0"
end

# Date parsing
gem "chronic"

# Searching
gem "pg_search"

# Settings
gem "rails-settings-cached", "~> 2.9"

# Pagination
gem "pagy"

# Backup/restore with zip file
gem "rubyzip", "~> 2.3"

# Haml templating
gem "haml", "< 7"
gem "haml-rails"

# Parses links out of strings
gem "linkify-it-rb", "~> 4.0"

# Profiler and perf
gem "flamegraph"
gem "memory_profiler"
gem "rack-mini-profiler", "~> 3.3"
gem "stackprof"

gem "kamal", "~> 1.3", require: false
