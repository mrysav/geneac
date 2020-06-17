# frozen_string_literal: true

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

# This is here primarily to use fixture_file_upload in Factories
FactoryBot::SyntaxRunner.class_eval do
  include ActionDispatch::TestProcess
end
