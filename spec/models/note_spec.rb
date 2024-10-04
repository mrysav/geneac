# frozen_string_literal: true

require "rails_helper"

RSpec.describe Note do
  let(:note) { described_class.new(id: 1, title: "Test note!", rich_content: "Hello world!", date_string:) }

  describe "#date" do
    context "with no date_string" do
      let(:date_string) { nil }

      it "sets date as nil" do
        expect(note.date).to be_nil
      end
    end

    context "with hyphenated date_string" do
      let(:date_string) { "10-15-1985" }

      it "sets date year" do
        expect(note.date.year).to eq 1985
      end
    end
  end
end
