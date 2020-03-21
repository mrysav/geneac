# frozen_string_literal: true

require 'simplecov'
SimpleCov.start 'rails' do
  add_filter '/app/dashboards/'
  add_filter '/app/controllers/admin/'
  add_filter '/app/policies/'
  add_filter '/app/fields/'
  add_filter '/app/channels/'
  add_filter '/app/mailers/'
end

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include FactoryBot::Syntax::Methods
end
