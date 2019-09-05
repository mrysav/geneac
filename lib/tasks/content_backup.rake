# frozen_string_literal: true

require 'zip'

namespace :content do
  desc 'Backup all content'
  task backup: :environment do
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

    stringio.rewind        # reposition buffer pointer to the beginning
    print stringio.sysread # write buffer to stdout
    $stdout.flush
  end
end
