# frozen_string_literal: true

require 'rails_helper'
require_relative '../helpers/history_helper'

RSpec.describe Fact, type: :request do
  let(:admin) { create(:user, :admin) }

  before do
    login_as admin
  end

  describe '#POST create' do
    before do
      post admin_facts_path, params: { fact: { fact_type: 'death' } }
    end

    it 'creates the fact' do
      expect(described_class.last.fact_type).to eq('death')
    end

    it_behaves_like 'records the edit history' do
      let(:action) { 'create' }
      let(:resource) { described_class.last }
      let(:edited_at) { described_class.last.created_at }
      let(:user) { admin }
    end
  end

  describe '#PUT update' do
    let(:fact) { create(:fact, fact_type: 'death') }

    before do
      put admin_fact_path(id: fact.id), params: { fact: { fact_type: 'birth' } }
    end

    it 'updates the fact' do
      expect(fact.reload.fact_type).to eq('birth')
    end

    it_behaves_like 'records the edit history' do
      let(:action) { 'update' }
      let(:resource) { described_class.last }
      let(:edited_at) { described_class.last.updated_at }
      let(:user) { admin }
    end
  end
end
