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
    citation.attrs['links'].each do |link|
      citation_text.sub!(
        html_escape(link['text']),
        link_to(link['text'], link['url'])
      )
    end

    citation_text
  end
end
