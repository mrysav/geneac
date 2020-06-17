# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateSnapshotJob, type: :job do
  before :each do
    Snapshot.drop_em_all!

    10.times do
      create(:photo)
    end

    10.times do
      create(:person)
    end
  end

  context 'creating snapshot' do
    it 'creates a backup of the entire database' do
      expect(Snapshot.count).to eq(0)
      CreateSnapshotJob.perform_now
      expect(Snapshot.count).to eq(1)
    end
  end
end
