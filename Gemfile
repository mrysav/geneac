source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.4.8"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "8.1.1"
# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"
# Use sqlite3 as the database for Active Record
gem "sqlite3", ">= 2.1"
# Use Puma as the app server
gem "puma", ">= 6.4"
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

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
# gem "kamal", "~> 2.5", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.12"
gem "ruby-vips"

# Ruby core maintained gems
gem "open-uri"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  gem "factory_bot_rails"
  gem "rails-controller-testing"
  gem "rspec-rails", "~> 8.0"
  gem "timecop"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "web-console", ">= 4.1.0"

  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem "flamegraph"
  gem "memory_profiler"
  gem "rack-mini-profiler", "~> 4.0"
  gem "stackprof"

  # Linters and other tools
  gem "erb_lint", require: false
  gem "rubocop", require: false
  gem "rubocop-capybara", require: false
  gem "rubocop-factory_bot", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rake", require: false
  gem "rubocop-rspec", require: false
  gem "rubocop-rspec_rails", require: false
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
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
gem "administrate", "~> 1.0.0.beta.3"
# administrate plugins
gem "administrate-field-nested_has_many", "~> 2.1"
# we don't want this here, but this is where we're at for now
gem "sassc", "= 2.4.0"

# For content tagging
gem "acts-as-taggable-on", "~> 13.0"

# Date parsing
gem "chronic"

# Settings
gem "rails-settings-cached", "~> 2.9"

# Pagination
gem "pagy"

# Backup/restore with zip file
gem "rubyzip", "~> 3.1"

# Parses links out of strings
gem "linkify-it-rb", "~> 4.0"
