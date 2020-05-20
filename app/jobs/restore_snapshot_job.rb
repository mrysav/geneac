# frozen_string_literal: true

require 'zip'

# Replaces the internal database contents with that of the snapshot.
class RestoreSnapshotJob < ApplicationJob
  include Rails.application.routes.url_helpers

  queue_as :default

  def perform(snapshot)
    delete_all_data

    snapshot.archive.open do |zipfile|
      Zip::File.open_buffer(zipfile) do |zip|
        notes_buffer = {}
        json_buffer = {}

        zip.each do |entry|
          istream = zip.get_input_stream(entry)
          if entry.name.end_with?('.json')
            if %w[manifest.json Person.json Note.json Photo.json].include? entry.name
              handle_json(entry.name, istream)
            else
              json_buffer[entry.name] = istream.read
            end
          end
          handle_photo(entry.name, istream) if entry.name.start_with?('Photos/')
          if entry.name.start_with?('Notes/')
            handle_note(entry.name, istream, notes_buffer)
          end
        end

        notes_buffer.each do |k, v|
          n = Note.find(k)
          n.rich_content = v
          n.save!(touch: false)
        end

        json_buffer.each do |k, v|
          handle_json(k, StringIO.new(v))
        end
      end
    end
  end

  def delete_all_data
    [Person, Note, Photo, Fact, Citation].each(&:drop_em_all!)
  end

  def batch_create(model_type, obj_list)
    obj_list.each do |obj|
      model_type.create! obj
    end
  end

  def handle_json(filename, io)
    return if filename.end_with? 'manifest.json'

    json_list = JSON.parse(io.read)
    model_name = filename.gsub('.json', '').constantize
    batch_create(model_name, json_list)
  end

  def handle_photo(filename, io)
    fn_cap = filename.match(/([0-9]+)_(.+)/)
    photo_id = fn_cap.captures[0]
    photo_filename = fn_cap.captures[1]
    photo = Photo.find(photo_id)
    # TODO: patch this so the photo doesn't have to be read into memory
    photo.image.attach(io: StringIO.new(io.read), filename: photo_filename)
    photo.save!
  end

  # TODO: This needs to handle attachments too
  # This is broken for now
  def handle_note(filename, io, notes_buffer)
    content_match = filename.match(%r{\ANotes\/note_([0-9]+)\.html\z})
    attachment_match = filename.match(%r{\ANotes\/note_([0-9]+)\/.+\z})

    if content_match
      note_id = content_match.captures[0]
      notes_buffer[note_id] = io.read
    elsif attachment_match
      note_id = attachment_match.captures[0]

      unless notes_buffer.key?(note_id)
        throw "Note #{note_id} not processed before attachment #{filename}"
      end

      note = notes_buffer[note_id]
      inner_html = Nokogiri::HTML(note)

      fname = filename.gsub!(%r{^Notes\/note_[0-9]+/}, '')

      # TODO: Possible bug!
      # See the create_snapshot_job for the duplicate file/filename problem
      inner_html.css("action-text-attachment[filename='#{fname}']")
                .each do |attachment|
        content_type = attachment['content-type']
        blob = ActiveStorage::Blob.create_and_upload! io: StringIO.new(io.read),
                                                      filename: fname,
                                                      content_type: content_type
        sgid = blob.to_sgid
        attachment['sgid'] = sgid

        url = rails_blob_path(blob, disposition: 'attachment', only_path: true)

        img = attachment.css('img')[0]
        img['src'] = url if img
        attachment['url'] = url
      end

      notes_buffer[note_id] = inner_html.to_s
    end
  end
end
