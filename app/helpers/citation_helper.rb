# frozen_string_literal: true

# Helper that will render citation text as formatted HTML.
module CitationHelper
  def render_citation(citation)
    replace_links(citation).html_safe
  end

  private

  # Replaces all probably links with proper hyper links for rendering
  # First it HTML-escapes the raw citation text string prevent XSS
  def replace_links(citation)
    return citation.text unless citation.attrs && citation.attrs['links']

    citation_text = html_escape(citation.text)
    citation.attrs['links'].reverse_each do |link|
      split = link['index']
      before = html_escape(citation_text.slice(0, split))
      after = citation_text.slice(split + link['text'].length, citation_text.length)
      citation_text = "#{before}#{link_to(link['text'], link['url'])}#{after}"
    end

    citation_text
  end
end
