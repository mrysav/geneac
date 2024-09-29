# frozen_string_literal: true

require "rails_helper"

RSpec.describe Fact, type: :model do
  describe ".birth_dates" do
    let!(:birth_dates) { create_list(:fact, 2, fact_type: described_class::Types::BIRTH) }

    it "returns birth date facts" do
      expect(described_class.birth_dates).to match_array birth_dates
    end

    context "when there are non-birth date facts" do
      let!(:non_birth_dates) { create_list(:fact, 2) }

      it "does not return non-birth date facts" do
        expect(described_class.birth_dates & non_birth_dates).to eq []
      end
    end
  end

  describe ".birthdays_in_range" do
    let(:birthday_range_start) { Time.zone.today }
    let(:birthday_range_end) { Time.zone.today + 3.days }
    let(:birthday_limit) { 5 }
    let(:in_range_birthdays) do
      Array.new(3) do |i|
        create(
          :fact,
          fact_type: described_class::Types::BIRTH,
          date_string: (Time.zone.today + i.days).strftime("%F")
        )
      end
    end

    def birthdays_in_range
      described_class.birthdays_in_range(birthday_range_start, birthday_range_end, birthday_limit)
    end

    before do
      Timecop.travel(DateTime.current.change(hour: 12))
      in_range_birthdays
    end

    after do
      Timecop.return
    end

    it "returns birthdays within the given range" do
      expect(birthdays_in_range).to match_array in_range_birthdays
    end

    context "when there are birthdays with invalid date formats" do
      let!(:invalid_birthdays) do
        [
          create(:fact, fact_type: described_class::Types::BIRTH, date_string: "text"),
          create(:fact, fact_type: described_class::Types::BIRTH, date_string: "1998")
        ]
      end

      it "filters out birthdays with invalid date formats" do
        expect(birthdays_in_range & invalid_birthdays).to eq []
      end
    end

    # TODO: This was broken in the move to SQLite since it doesn't support fancy dates like Postgres
    context "when there are birthdays in a variety of date formats", :skip do
      let!(:in_range_birthdays) do
        [
          create(:fact, fact_type: described_class::Types::BIRTH, date_string: Time.zone.today.strftime("%F")),
          create(
            :fact,
            fact_type: described_class::Types::BIRTH,
            date_string: (Time.zone.today + 1.day).strftime("%v")
          ),
          create(
            :fact,
            fact_type: described_class::Types::BIRTH,
            date_string: (Time.zone.today + 2.days).strftime("%A %-d %B %Y")
          ),
          create(
            :fact,
            fact_type: described_class::Types::BIRTH,
            date_string: (Time.zone.today + 3.days).strftime("%D")
          )
        ]
      end

      it "correctly compares the various formats" do
        expect(birthdays_in_range).to eq in_range_birthdays
      end
    end

    context "when there are birthdays outside the given range" do
      let!(:out_of_range_birthdays) do
        Array.new(3) do |i|
          create(
            :fact,
            fact_type: described_class::Types::BIRTH,
            date_string: (Time.zone.today + (i + 10).days).strftime("%B %-d, %Y")
          )
        end
      end

      it "does not return birthdays outside the given range" do
        expect(birthdays_in_range & out_of_range_birthdays).to eq []
      end
    end

    context "when there are more matching birthdays than the given limit" do
      let(:birthday_limit) { 2 }

      it "returns a limited number of birthdays" do
        expect(birthdays_in_range).to match_array in_range_birthdays[0..1]
      end
    end
  end
end
