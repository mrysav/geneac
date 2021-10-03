# frozen_string_literal: true

require 'rails_helper'
require_relative '../helpers/history_helper'

RSpec.describe Photo, type: :request do
  let(:admin) { create(:user, :admin) }

  before do
    login_as admin
  end

  describe '#POST create' do
    before do
      post admin_photos_path, params: { photo: { title: 'Photo' } }
    end

    it 'creates the photo' do
      expect(described_class.last.title).to eq('Photo')
    end

    it_behaves_like 'records the edit history' do
      let(:action) { 'create' }
      let(:resource) { described_class.last }
      let(:edited_at) { described_class.last.created_at }
      let(:user) { admin }
    end
  end

  describe '#PUT update' do
    let(:photo) { create(:photo, title: 'Photo', image: nil) }

    before do
      put admin_photo_path(id: photo.id), params: { photo: { title: 'Photo 2' } }
    end

    it 'updates the photo' do
      expect(photo.reload.title).to eq('Photo 2')
    end

    it_behaves_like 'records the edit history' do
      let(:action) { 'update' }
      let(:resource) { described_class.last }
      let(:edited_at) { described_class.last.updated_at }
      let(:user) { admin }
    end
  end
end
