# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :photo do
    title { Faker::Music::GratefulDead.song }
    description { Faker::Lorem.paragraphs }
    date_string do
      Faker::Date.between(from: 200.years.ago, to: Date.today)
                 .strftime('%Y-%mm-%d')
    end

    after(:build) { |photo|
      allow(photo).to receive(:add_create_history).and_return(true)
      photo.image.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'image.jpg')), filename: 'image.jpg'
      )
    }

    after(:create) do |photo|
      allow(photo).to receive(:add_create_history).and_call_original
    end
  end
end
