# frozen_string_literal: true

require 'erb_lint/cli'

namespace :lint do
  desc 'Run erb-lint on all .erb files'
  task erb: :environment do
    cli = ERBLint::CLI.new
    result = cli.run(['.'])
    abort 'Errors found!' unless result
  end
end
