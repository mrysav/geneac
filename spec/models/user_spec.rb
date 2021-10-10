# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { described_class.new(id: 99) }

  describe '.current_user' do
    before do
      Thread.current[:current_user] = user
    end

    after do
      Thread.current[:current_user] = nil
    end

    it 'returns the current user from the thread' do
      expect(described_class.current_user).to eq user
    end
  end

  describe '.current_user=' do
    let(:current_thread) { {} }

    before do
      described_class.current_user = user
    end

    after do
      Thread.current[:current_user] = nil
    end

    it 'sets the current user on the thread' do
      expect(Thread.current[:current_user]).to eq(user)
    end
  end
end
