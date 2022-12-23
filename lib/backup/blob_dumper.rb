# frozen_string_literal: true

require 'fileutils'

module Backup
  # Provides a method for dumping the contents of blob storage.
  # Block expects the key (filename) and an IO object to the file.
  class BlobDumper
    def dump
      ActiveStorage::Blob.all.each do |blob|
        blob.download do |io|
          yield(blob.key, io)
        end
      end
    end
  end
end
