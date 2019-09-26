# frozen_string_literal: true

require 'zip'

namespace :snapshot do
  desc 'Create a snapshot of all content'
  task create: :environment do
    stringio = Zip::OutputStream.write_buffer do |zio|
      zio.put_next_entry('Person.json')
      zio.write(Person.all.to_json)

      zio.put_next_entry('Note.json')
      zio.write(Note.all.to_json)

      zio.put_next_entry('Fact.json')
      zio.write(Fact.all.to_json)

      zio.put_next_entry('Photo.json')
      zio.write(Photo.all.to_json)

      Photo.all.each do |photo|
        zio.put_next_entry("Photos/#{photo.id}_#{photo.image.filename}")
        zio.write(photo.image.download)
      end
    end
    stringio.rewind # reposition buffer pointer to the beginning

    snapshot = Snapshot.create(
      archive: ActiveStorage::Blob.create_after_upload!(
        io: stringio,
        filename: "geneac_snapshot_#{Time.now.to_i}.zip",
        content_type: 'application/zip'
      )
    )
    snapshot.save!

    print "Snapshot created. URL:\n\n#{snapshot.archive_url}\n\n"
  end
end
