require "rails_helper"

RSpec.describe SearchDocument do
  let(:note) { create(:note, title: "xyzzy") }
  let(:photo) { create(:photo, title: "xyzzy") }

  before do
    described_class.find_or_create_by(searchable: note)
                   .update!(privacy_scope: PrivacyScope::PUBLIC, content: "xyzzy")
    described_class.find_or_create_by(searchable: photo)
                   .update!(privacy_scope: PrivacyScope::PRIVATE, content: "xyzzy")
  end

  describe "#search" do
    it "performs a full text search" do
      results = described_class.search("xyzzy", PrivacyScope::PRIVATE)
      expect(results.map(&:searchable)).to eq([note, photo])
    end

    it "hides private search documents when public scope is specified" do
      results = described_class.search("xyzzy", PrivacyScope::PUBLIC)
      expect(results.map(&:searchable)).to eq([note])
    end
  end
end
