# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :note do
    title { Faker::Music::GratefulDead.song }
    rich_content { 'Hello world! <b>Bold move.</b>' }

    trait :has_date do
      date_string do
        Faker::Date.between(from: 50.years.ago, to: Date.today).strftime('%F')
      end
    end
  end
end
