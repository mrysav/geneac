# frozen_string_literal: true

FactoryBot.define do
  factory :fact do
    fact_type { %w[Residence Marriage Baptism Divorce].sample }
    date_string do
      Faker::Date.between(from: 50.years.ago, to: Date.today).strftime('%F')
    end
    place { Faker::Address.full_address }

    trait :attached_to_person do
      association :factable, factory: :person
    end
  end
end
