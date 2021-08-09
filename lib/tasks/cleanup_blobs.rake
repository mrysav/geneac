# frozen_string_literal: true

namespace :blobs do
  desc 'Delete unattached blobs'
  task cleanup: :environment do
    total_sum = ActiveStorage::Blob.unattached.map(&:byte_size).sum
    puts "Clearing #{total_sum} bytes..."
    ActiveStorage::Blob.unattached.map(&:destroy)
  end
end
