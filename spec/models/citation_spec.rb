# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Citation, type: :model do
  describe 'without a link' do
    subject(:citation) { create(:citation) }

    it 'does not parse a link' do
      expect(citation.attrs['links']).to eq []
    end
  end

  describe 'with a link' do
    subject(:citation) { create(:citation, :with_link) }

    it 'parses a link' do
      expect(citation.attrs['links'][0]['url']).to eq 'http://www.example.com'
    end
  end
end
