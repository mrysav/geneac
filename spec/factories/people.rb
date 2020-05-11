# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :person do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    gender { ['Male', 'Female', 'Unknown', ''].sample }
    bio { Faker::Quote.famous_last_words }

    trait :has_birthday do
      birth_date_string do
        Faker::Date.birthday(min_age: 91,
                             max_age: 200).strftime('%F')
      end
      birthplace { Faker::Address.city + ', ' + Faker::Address.country }
    end

    trait :has_deathday do
      death_date_string do
        Faker::Date.between(from: birth_date || 200.years.ago,
                            to: 91.years.ago).strftime('%F')
      end
      burialplace { Faker::Address.city + ', ' + Faker::Address.country }
    end
  end
end
