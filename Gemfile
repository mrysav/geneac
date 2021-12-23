# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.0'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.5'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.9.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'pry'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  # gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'

  # Code coverage
  gem 'simplecov', require: false

  # Fancier matchers!
  gem 'shoulda-matchers', '~> 5.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development do
  gem 'brakeman', '>= 4.0', require: false
  gem 'erb_lint', require: false
  gem 'haml_lint', require: false
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false
  gem 'solargraph', require: false
  gem 'yard', require: false
end

# Workin' jobs
gem 'resque'

# For generating fake data - used in a rake task as well as tests
gem 'faker'

group :development, :test do
  gem 'database_cleaner-active_record'
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 4.0.0'
  gem 'timecop'
end

# Use Devise for authentication
gem 'devise', '~> 4.7'

# Pundit for policies
gem 'pundit'

# simple_form and country_select for easier forms
gem 'country_select'
gem 'simple_form', '~> 5.0'

# administrate for content management
gem 'administrate', '~> 0.13'
# administrate plugins
gem 'administrate_collapsible_navigation', github: 'mrysav/administrate_collapsible_navigation', branch: 'master'
gem 'administrate-field-nested_has_many'

# For content tagging
gem 'acts-as-taggable-on', '~> 7.0'

gem 'aws-sdk-rails'
group :production do
  # For S3
  gem 'aws-sdk-s3'
end

# Date parsing
gem 'chronic'

# Searching
gem 'pg_search'

# Settings
gem 'rails-settings-cached', '~> 2.0'

# Pagination
gem 'pagy'

# Backup/restore with zip file
gem 'rubyzip'

# FontAwesome - using Rails/Sprockets version since there is no JS
gem 'font-awesome-sass', '~> 5.12.0'

# Haml templating
gem 'haml'
gem 'haml-rails'

# Parses links out of strings
gem 'linkify-it-rb'

# Profiler and perf
gem 'flamegraph'
gem 'memory_profiler'
gem 'rack-mini-profiler', '~> 2.0'
gem 'stackprof'

# Semantic logging
gem 'amazing_print'
gem 'rails_semantic_logger'
