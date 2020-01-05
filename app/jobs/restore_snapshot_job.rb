# frozen_string_literal: true

require 'zip'

# Replaces the internal database contents with that of the snapshot.
class RestoreSnapshotJob < ApplicationJob
  queue_as :default

  def perform(snapshot)
    delete_all_data

    snapshot.archive.open do |zipfile|
      Zip::InputStream.open(zipfile) do |zip|
        while (entry = zip.get_next_entry)
          handle_json(entry.name, zip) if entry.name.end_with?('.json')
          handle_photo(entry.name, zip) if entry.name.start_with?('Photos/')
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
end
