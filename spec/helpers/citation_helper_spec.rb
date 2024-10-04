# frozen_string_literal: true

require "rails_helper"

RSpec.describe CitationHelper do
  describe "with plain text" do
    let(:citation) { create(:citation) }

    it "renders unformatted" do
      rendered_text = helper.render_citation citation
      expect(rendered_text).to eq citation.text
    end
  end

  describe "with link" do
    let(:citation) { create(:citation, :with_link) }

    it "renders the link" do
      rendered_text = helper.render_citation citation
      expect(rendered_text).to match %r{<a href="http://www.example.com"}
    end
  end

  describe "with link and injected html" do
    let(:citation) { create(:citation, :with_link_and_html) }

    it "renders the link" do
      rendered_text = helper.render_citation citation
      expect(rendered_text).to match %r{<a href="http://www.example.com"}
    end

    it "does not escape html" do
      rendered_text = helper.render_citation citation
      expect(rendered_text).to match %r{<i>.+</i>}
    end
  end
end
