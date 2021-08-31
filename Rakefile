# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

require 'rubocop/rake_task'
RuboCop::RakeTask.new

require 'haml_lint/rake_task'
HamlLint::RakeTask.new

Rails.application.load_tasks
