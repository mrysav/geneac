# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :note do
    title { Faker::Music::GratefulDead.song }
    rich_content { "<b>#{Faker::Music::Prince.song}</b><br/>#{Faker::Lorem.paragraphs}" }

    after(:build) { |photo|
      allow(photo).to receive(:add_create_history).and_return(true)
    }

    after(:create) do |photo|
      allow(photo).to receive(:add_create_history).and_call_original
    end

    trait :with_date do
      date_string do
        Faker::Date.between(from: 50.years.ago, to: Time.zone.today).strftime('%F')
      end
    end
  end
end
