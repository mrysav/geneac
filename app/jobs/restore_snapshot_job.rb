# frozen_string_literal: true

require 'zip'

# Replaces the internal database contents with that of the snapshot.
class RestoreSnapshotJob < ApplicationJob
  queue_as :default

  def perform(snapshot)
    delete_all_data

    snapshot.archive.open do |zipfile|
      Zip::File.open_buffer(zipfile) do |zip|
        zip.each do |entry|
          istream = zip.get_input_stream(entry)
          handle_json(entry.name, istream) if entry.name.end_with?('.json')
          handle_photo(entry.name, istream) if entry.name.start_with?('Photos/')
          handle_note(entry.name, istream) if entry.name.start_with?('Notes/')
        end
      end
    end
  end

  def delete_all_data
    [Person, Note, Photo, Fact].each(&:drop_em_all!)
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
  def handle_note(filename, io)
    fn_cap = filename.match(/note_([0-9]+)/)
    note_id = fn_cap.captures[0]
    note = Note.find(note_id)
    note.rich_content = io.read
    note.save!
  end
end
