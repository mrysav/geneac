# frozen_string_literal: true

require "faker"

FactoryBot.define do
  factory :snapshot do
    trait :v1 do
      archive do
        fixture_file_upload(
          Rails.root.join("spec/fixtures/files/reference_snapshot_v1.zip"),
          "application/zip"
        )
      end
    end
  end
end
