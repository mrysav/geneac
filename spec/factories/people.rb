# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :person do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    gender { ['Male', 'Female', 'Unknown', ''].sample }
    bio { Faker::Quote.famous_last_words }
  end
end
