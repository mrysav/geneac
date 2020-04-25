# frozen_string_literal: true

require 'zip'

# Job that creates a snapshot of all resources on the sites
class CreateSnapshotJob < ApplicationJob
  queue_as :default

  def perform(*)
    stringio = Zip::OutputStream.write_buffer do |zio|
      add_manifest(zio)
      add_people(zio)
      add_facts(zio)
      add_notes(zio)
      add_photos(zio)
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
  end

  def add_manifest(zio)
    manifest = {
      # Version 1/unversioned: Notes have markdown text
      # Version 2: Notes have rich text HTML file with them
      version: '2'
    }

    zio.put_next_entry('manifest.json')
    zio.write(manifest.to_json)
  end

  def add_photos(zio)
    return if Photo.count.zero?

    zio.put_next_entry('Photo.json')
    zio.write(Photo.all.to_json)

    Photo.all.each do |photo|
      zio.put_next_entry("Photos/#{photo.id}_#{photo.image.filename}")
      zio.write(photo.image.download)
    end
  end

  def add_notes(zio)
    return if Note.count.zero?

    zio.put_next_entry('Note.json')
    zio.write(Note.all.to_json)

    Note.all.each do |n|
      serialize_actiontext(n.rich_content, 'Notes', "note_#{n.id}", zio)
    end
  end

  def add_people(zio)
    return if Person.count.zero?

    zio.put_next_entry('Person.json')
    zio.write(Person.all.to_json)
  end

  def add_facts(zio)
    return if Fact.count.zero?

    zio.put_next_entry('Fact.json')
    zio.write(Fact.all.to_json)
  end

  # Decomposes a rich_text field by saving the text as well
  # as the associated attachments.
  #
  # TODO: Possible bug!
  #
  # If two attachments are different files, but have the same filename,
  # this could result in overwriting one of them.
  def serialize_actiontext(rich_text, root, path, zio)
    inner_html = Nokogiri::HTML(rich_text.body.to_s)

    zio.put_next_entry("#{root}/#{path}.html")
    zio.write(inner_html.css('div.trix-content').inner_html.to_s)

    inner_html.css('action-text-attachment').each do |attachment|
      blob = ActionText::Attachable.from_attachable_sgid(attachment['sgid'])
      zio.put_next_entry("#{root}/#{path}/#{blob.filename}")
      zio.write(blob.download)

      img = attachment.css('img')[0]
      img['src'] = "#{path}/#{blob.filename}" if img

      # Unset ActionText attrs - we'll infer them on deserialize
      attachment['sgid'] = ''
      attachment['url'] = ''
    end
  end
end
