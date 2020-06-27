# frozen_string_literal: true

# Generates a 'friendly' URL for a given field
# and persists to a given database field.
module FriendlyUrlName
  extend ActiveSupport::Concern

  included do
    before_save :generate_friendly_url_name

    class_attribute :friendly_field
    class_attribute :friendly_field_name
    class_attribute :url_root

    def generate_friendly_url_name
      friendly_url_val = self[self.class.friendly_field]

      return if friendly_url_val&.present?

      slug = rand(10_000..1_000_000)
      model_name = send(self.class.friendly_field_name)
      url_name = model_name.downcase
                           .gsub(/[^0-9a-z ]/, '')
                           .tr(' ', '_')[0..20]
      self[self.class.friendly_field] = "#{slug}_#{url_name}"
    end

    def url_path
      "/#{self.class.url_root}/#{self[self.class.friendly_field]}"
    end
  end

  class_methods do
    def has_friendly_url_name(field:, field_name:, url_root: nil)
      self.friendly_field = field
      self.friendly_field_name = field_name
      self.url_root = url_root || name.downcase.pluralize
    end
  end
end
