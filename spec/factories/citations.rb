# frozen_string_literal: true

FactoryBot.define do
  factory :citation do
    text { 'Citation. Some book, 2021. Read on 20 May 2021.' }
    association :citable, factory: :note

    trait :with_link do
      text { 'Citation. Mysite, 2020. www.example.com. Accessed 20 May 2020' }
    end

    trait :with_link_and_html do
      text { 'Citation. Mysite, 2020. www.example.com. <i>Accessed 20 May 2020</i>' }
    end
  end
end
