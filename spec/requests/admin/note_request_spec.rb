# frozen_string_literal: true

require 'rails_helper'
require_relative '../helpers/history_helper'

RSpec.describe Note, type: :request do
  let(:admin) { create(:user, :admin) }

  before do
    login_as admin
  end

  describe '#POST create' do
    before do
      post admin_notes_path, params: { note: { title: 'Note' } }
    end

    it 'creates the note' do
      expect(described_class.last.title).to eq('Note')
    end

    it_behaves_like 'records the edit history' do
      let(:action) { 'create' }
      let(:resource) { described_class.last }
      let(:edited_at) { described_class.last.created_at }
      let(:user) { admin }
    end
  end

  describe '#PUT update' do
    let(:note) { create(:note, title: 'Note') }

    before do
      put admin_note_path(id: note.id), params: { note: { title: 'Note 2' } }
    end

    it 'updates the note' do
      expect(note.reload.title).to eq('Note 2')
    end

    it_behaves_like 'records the edit history' do
      let(:action) { 'update' }
      let(:resource) { described_class.last }
      let(:edited_at) { described_class.last.updated_at }
      let(:user) { admin }
    end
  end
end
