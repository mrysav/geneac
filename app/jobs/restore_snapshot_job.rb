# frozen_string_literal: true

require "zip"

# Replaces the internal database contents with that of the snapshot.
class RestoreSnapshotJob < ApplicationJob
  queue_as :default

  RESTORABLE_MODELS = [Person, Note, Photo, Fact, Citation].freeze

  def perform(snapshot)
    delete_all_data

    snapshot.archive.open do |zipfile|
      Zip::File.open_buffer(zipfile) do |zip|
        notes_buffer = {}
        json_buffer = {}

        zip.each do |entry|
          istream = zip.get_input_stream(entry)
          if entry.name.end_with?(".json")
            if %w[manifest.json Person.json Note.json Photo.json].include? entry.name
              handle_json(entry.name, istream)
            else
              json_buffer[entry.name] = istream.read
            end
          end
          handle_photo(entry.name, istream) if entry.name.start_with?("Photos/")
          handle_note(entry.name, istream, notes_buffer) if entry.name.start_with?("Notes/")
        end

        notes_buffer.each do |k, v|
          n = Note.find(k)
          # Hack! We want to preserve the original updated_at, so save it here
          updated_at = n.updated_at
          n.rich_content = v
          n.save_without_history!
          n.update_columns(updated_at:)
        end

        json_buffer.each do |k, v|
          handle_json(k, StringIO.new(v))
        end
      end
    end

    update_all_seqs
  end

  def delete_all_data
    RESTORABLE_MODELS.each(&:drop_em_all!)
  end

  def update_all_seqs
    RESTORABLE_MODELS.each(&:update_seq!)
  end

  def batch_create(model_type, obj_list)
    obj_list.each do |obj|
      instance = model_type.new(obj)
      instance.save_without_history!
    end
  end

  def handle_json(filename, io)
    return if filename.end_with? "manifest.json"

    json_list = JSON.parse(io.read)
    model_name = filename.gsub(".json", "").constantize
    batch_create(model_name, json_list)
  end

  def handle_photo(filename, io)
    fn_cap = filename.match(/([0-9]+)_(.+)/)
    photo_id = fn_cap.captures[0]
    photo_filename = fn_cap.captures[1]
    photo = Photo.find(photo_id)
    orig_updated_at = photo.updated_at
    # @todo patch this so the photo doesn't have to be read into memory
    photo.image.attach(io: StringIO.new(io.read), filename: photo_filename)
    photo.update_columns(updated_at: orig_updated_at)
  end

  def handle_note(filename, io, notes_buffer)
    content_match = filename.match(%r{\ANotes/note_([0-9]+)\.html\z})
    attachment_match = filename.match(%r{\ANotes/note_([0-9]+)/.+\z})

    if content_match
      note_id = content_match.captures[0]
      notes_buffer[note_id] = io.read
    elsif attachment_match
      note_id = attachment_match.captures[0]

      throw "Note #{note_id} not processed before attachment #{filename}" unless notes_buffer.key?(note_id)

      note = notes_buffer[note_id]
      inner_html = Nokogiri::HTML(note)

      fname = filename.gsub!(%r{^Notes/note_[0-9]+/}, "")

      # @todo Possible bug!
      # See the create_snapshot_job for the duplicate file/filename problem
      inner_html.css("action-text-attachment[filename='#{fname}']")
                .each do |attachment|
                  content_type = attachment["content-type"]
                  blob = ActiveStorage::Blob.create_and_upload!(
                    io: StringIO.new(io.read),
                    filename: fname,
                    content_type:
                  )
                  sgid = blob.to_sgid(expires_in: nil, for: "attachable")
                  url = rails_blob_path(blob, disposition: :attachment, only_path: true)

                  attachment["sgid"] = sgid
                  attachment["url"] = url
                  attachment.inner_html = ""
      end

      notes_buffer[note_id] = inner_html.to_s
    end
  end
end
