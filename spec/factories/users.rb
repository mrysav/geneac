# frozen_string_literal: true

require "faker"

FactoryBot.define do
  factory :user do
    name     { Faker::Internet.username }
    password { Faker::Internet.password }
    email    { Faker::Internet.email }

    trait :admin do
      admin { true }
    end
  end
end
