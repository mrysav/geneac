# frozen_string_literal: true

# ActiveStorage wrapper for storing database backups
class Snapshot < ApplicationRecord
  has_one_attached :archive

  def archive_url
    Rails.application.routes.url_helpers.rails_blob_url(
      archive.blob,
      disposition: 'attachment',
      host: Rails.application.config.action_mailer.default_url_options[:host],
      port: Rails.application.config.action_mailer.default_url_options[:port]
    )
  end
end
