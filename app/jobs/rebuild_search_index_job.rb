# frozen_string_literal: true

# Rebuild the entire multisearch index
class RebuildSearchIndexJob < ApplicationJob
  queue_as :default

  def perform
    [Note, Photo, Person].each do |model|
      model.find_each do |o|
        if o.respond_to?(:save_without_history!)
          o.save_without_history!
        else
          o.save!
        end
        Rails.logger.info "Rebuilt SearchDocument for #{o.class} ##{o.id}"
      end
    end
  end
end
