# frozen_string_literal: true

module Backup
  # Provides a method for dumping the contents of blob storage.
  # Block expects the key (filename) and an IO object to the file.
  class BlobDumper
    def dump
      ActiveStorage::Blob.find_each do |blob|
        blob.download do |io|
          yield(blob.key, io)
        end
      rescue ActiveStorage::FileNotFoundError
        Rails.logger.error "Blob not found! Blob: { id: #{blob.id}, key: #{blob.key}, filename: #{blob.filename}"
      end
    end
  end
end
