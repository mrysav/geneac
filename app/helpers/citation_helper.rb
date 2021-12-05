# frozen_string_literal: true

# Helper that will render citation text as formatted HTML.
module CitationHelper
  # Replaces all probable links with proper hyperlinks for rendering
  def render_citation(citation)
    return citation.text unless citation.attrs && citation.attrs['links']

    citation_text = citation.text
    citation.attrs['links'].reverse_each do |link|
      split = link['index']
      before = citation_text.slice(0, split)
      after = citation_text.slice(split + link['text'].length, citation_text.length)
      citation_text = "#{before}#{link_to(link['text'], link['url'])}#{after}"
    end

    citation_text
  end
end
