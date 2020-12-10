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
    image do
      Rack::Test::UploadedFile.new(
        Rails.root.join('spec/fixtures/files/image.jpg'),
        'image/jpg'
      )
    end
  end
end
