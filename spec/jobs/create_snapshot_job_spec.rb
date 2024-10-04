# frozen_string_literal: true

require "rails_helper"

RSpec.describe CreateSnapshotJob do
  before do
    Snapshot.drop_em_all!

    create_list(:photo, 10)

    create_list(:person, 10)
  end

  context "creating snapshot" do
    it "creates a backup of the entire database" do
      expect(Snapshot.count).to eq(0)
      described_class.perform_now
      expect(Snapshot.count).to eq(1)
    end
  end
end
