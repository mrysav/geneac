# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home', type: :request do
  describe '#index' do
    let(:birthday_setting) { true }
    let(:recent_birthdays) do
      Array.new(3) do |i|
        Fact.new(
          fact_type: Fact::Types::BIRTH_DATE,
          date_string: (Time.zone.today + i.days - 100.years).strftime('%B %-d, %Y'),
          factable: Person.new
        )
      end
    end

    before do
      allow(Setting).to receive(:require_login).and_return(false)
      allow(Setting).to receive(:show_recent_birthdays).and_return(birthday_setting)
      allow(Fact).to receive(:birthdays_in_range).and_return(recent_birthdays)
      get root_path
    end

    context "when the 'show recent birthdays' setting is true" do
      it 'returns recent birthdays' do
        expect(assigns(:recent_birthdays)).to match_array recent_birthdays
      end
    end

    context "when the 'show recent birthdays' setting is false" do
      let(:birthday_setting) { false }

      it 'does not return recent birthdays' do
        expect(assigns(:recent_birthdays)).to be_nil
      end
    end
  end
end
