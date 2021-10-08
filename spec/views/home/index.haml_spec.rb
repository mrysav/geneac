require 'rails_helper'

RSpec.describe 'home/index' do
  let(:recent_updates) do
    Array.new(3) do
      Person.new(
        first_name: 'Geordi', last_name: 'La Forge', url_root: 'example.com', friendly_field: 'laforge'
      )
    end
  end
  let(:recent_birthdays) do
    Array.new(3) do |i|
      Fact.new(
        fact_type: Fact::Types::BIRTH,
        date_string: (Time.zone.today + i.days - 100.years).strftime('%B %-d, %Y'),
        factable: Person.new(
          first_name: 'Tasha', last_name: 'Yar', url_root: 'example.com', friendly_field: 'yar'
        )
      )
    end
  end

  context 'when recent birthdays are assigned' do
    before do
      assign(:recent_birthdays, recent_birthdays)
    end

    it 'displays the birthday widget' do
      render

      expect(rendered).to match(/.+Recent Birthdays.+Tasha Yar.+Tasha Yar.+Tasha Yar.+/m)
    end
  end

  context 'when recent birthdays are not assigned' do
    before do
      assign(:recent_birthdays, [])
    end

    it 'does not display the birthday widget' do
      render

      expect(rendered).not_to match(/.+Recent Birthdays.+/m)
    end
  end

  context 'when recent updates are assigned' do
    before do
      assign(:recent_updates, recent_updates)
    end

    it 'displays the update widget' do
      render

      expect(rendered).to match(/.+Recent Updates.+Geordi La Forge.+Geordi La Forge.+Geordi La Forge.+/m)
    end
  end

  context 'when recent updates are not assigned' do
    before do
      assign(:recent_updates, [])
    end

    it 'does not display the update widget' do
      render

      expect(rendered).not_to match(/.+Recent Updates.+/m)
    end
  end
end
