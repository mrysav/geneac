require 'rails_helper'

RSpec.describe Photo, type: :model do
  let(:photo) { Photo.new(id: 1, title: 'Imageless photo', description: '*Here we go!*', date_string: date_string) }

  describe '#date' do
    context 'with no date_string' do
      let(:date_string) { nil }

      it 'sets date as nil' do
        expect(photo.date).to eq nil
      end
    end

    context 'with hyphenated date_string' do
      let(:date_string) { '10-31-2010' }

      it 'sets date year' do
        expect(photo.date.year).to eq 2010
      end
    end

    context 'with forward slash date_string' do
      let(:date_string) { '10/31/2010' }

      it 'sets date as nil' do
        expect(photo.date.year).to eq 2010
      end
    end
  end
end
