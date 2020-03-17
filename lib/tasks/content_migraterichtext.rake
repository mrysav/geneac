# frozen_string_literal: true

require 'commonmarker'

namespace :content do
  desc 'Migrate all legacy markdown fields to RichTextField'
  task migrate_rich_text: :environment do
    Note.all.each do |n|
      rendered_content = CommonMarker.render_html(n.content || '').html_safe
      n.rich_content = rendered_content
      n.content = nil
      n.save!
    end
  end
end
