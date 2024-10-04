# frozen_string_literal: true

require "digest"
require "json"
require "zip"

require "rails_helper"

RSpec.describe RestoreSnapshotJob do
  before do
    Snapshot.drop_em_all!

    create_list(:note, 5, :with_date)

    create_list(:photo, 3)

    create_list(:fact, 5, :attached_to_person)

    create_list(:person, 3)

    CreateSnapshotJob.perform_now
    expect(Snapshot.count).to eq(1)

    Note.drop_em_all!
    expect(Note.count).to eq(0)

    Photo.drop_em_all!
    expect(Photo.count).to eq(0)

    Person.drop_em_all!
    expect(Person.count).to eq(0)

    Fact.drop_em_all!
    expect(Fact.count).to eq(0)
  end

  context "restoring a snapshot" do
    it "restores notes" do
      described_class.perform_now(Snapshot.find(1))

      expect(Note.count).to eq(5)

      note = Note.first

      expect(note.title).not_to be_empty
      expect(note.rich_content.body.to_s).to match(%r{<b>.+</b>.+})
    end

    skip "restores the database from reference snapshot" do
      expect(Snapshot.count).to eq(0)
      described_class.perform_now(create(:snapshot, :v1))

      expect(Person.count).to eq(100)

      note_with_actiontext = Note.find(1)
      rich_text = note_with_actiontext.rich_content.body
      expect(rich_text.attachments[0].filename).to eq("1_photo_1.jpg")
      expect(rich_text.attachments[1].filename).to eq("cat_pdf.pdf")

      CreateSnapshotJob.perform_now
      expect(Snapshot.count).to eq(2)

      reference_snapshot = digest_snapshot Snapshot.find(1)
      new_snapshot = digest_snapshot Snapshot.find(2)

      expect(new_snapshot[:hashes].keys).to match_array(reference_snapshot[:hashes].keys)
      reference_snapshot[:hashes].each_key do |file|
        ref_hash = reference_snapshot[:hashes][file]
        new_hash = new_snapshot[:hashes][file]

        case file
        when /[A-Z][a-z]+\.json/
          # Print the actual different contents of each json file
          # if they don't match.
          ref_contents = reference_snapshot[:contents][file].sort_by { |a| a["id"] }
          new_contents = new_snapshot[:contents][file].sort_by { |a| a["id"] }

          expect(new_contents.count).to eq(ref_contents.count)
          new_contents.each_with_index do |p, i|
            expect(p).to include(ref_contents[i])
          end
        when %r{Notes/note_[0-9]+.html}
          normalized_ref = normalize_note_html(reference_snapshot[:contents][file])
          normalized_new = normalize_note_html(new_snapshot[:contents][file])

          # This avoids matching the actual attachment inner text, which can change
          expect(normalized_new[:attachments]).to match_array(normalized_ref[:attachments]), "attachments"
          expect(normalized_new[:contents]).to eq(normalized_ref[:contents]), "note contents"
        else
          expect(new_hash).to eq(ref_hash), file
        end
      end
    end
  end

  def digest_snapshot(snapshot)
    digest_contents = {
      hashes: {},
      contents: {}
    }
    snapshot.archive.open do |zipfile|
      Zip::File.open_buffer(zipfile) do |zip|
        zip.each do |entry|
          file_name = entry.name
          file_contents = zip.get_input_stream(entry).read.force_encoding("UTF-8")
          digest_contents[:hashes][file_name] = Digest::MD5.hexdigest(file_contents)
          digest_contents[:contents][file_name] = if file_name.ends_with?(".json")
                                                    JSON.parse(file_contents)
                                                  else
                                                    file_contents
                                                  end
        end
      end
    end
    digest_contents
  end

  ACTION_TEXT_ATTACHMENT = %r{<action-text-attachment(.+?)>.+</action-text-attachment>}m.freeze

  def normalize_note_html(note_html)
    attachments = []
    captures = ACTION_TEXT_ATTACHMENT.match(note_html)&.captures
    attachments += captures if captures

    normalized_text = note_html.gsub(ACTION_TEXT_ATTACHMENT, "")

    {
      attachments: attachments,
      contents: normalized_text
    }
  end
end
