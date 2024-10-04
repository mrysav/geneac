# frozen_string_literal: true

namespace :blobs do
  desc "Delete unattached blobs"
  task cleanup: :environment do
    total_sum = ActiveStorage::Blob.unattached.sum(&:byte_size)
    if total_sum.positive?
      puts "Clearing #{total_sum} bytes..."
      ActiveStorage::Blob.unattached.map(&:destroy)
    else
      puts "Nothing to do."
    end
  end
end
