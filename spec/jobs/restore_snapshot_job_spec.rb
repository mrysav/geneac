# frozen_string_literal: true

require 'digest'
require 'json'
require 'zip'

require 'rails_helper'

RSpec.describe RestoreSnapshotJob, type: :job do
  before :each do
    Snapshot.drop_em_all!
  end

  context 'restoring a v1 snapshot' do
    it 'restores the database from reference snapshot' do
      expect(Snapshot.count).to eq(0)
      RestoreSnapshotJob.perform_now(create(:snapshot, :v1))

      expect(Person.count).to eq(100)

      note_with_actiontext = Note.find(1)
      rich_text = note_with_actiontext.rich_content.body
      expect(rich_text.attachments[0].filename).to eq('1_photo_1.jpg')
      expect(rich_text.attachments[1].filename).to eq('cat_pdf.pdf')

      CreateSnapshotJob.perform_now
      expect(Snapshot.count).to eq(2)

      reference_snapshot = digest_snapshot Snapshot.find(1)
      new_snapshot = digest_snapshot Snapshot.find(2)

      expect(new_snapshot[:hashes].keys).to match_array(reference_snapshot[:hashes].keys)
      reference_snapshot[:hashes].keys.each do |file|
        ref_hash = reference_snapshot[:hashes][file]
        new_hash = new_snapshot[:hashes][file]
        # @TODO: there needs to be better equality checking for snapshots.
        # When restored, apparently sometimes things get out of order even
        # though the data *inside* each record is fine.
        if file.ends_with?('.json') && new_hash != ref_hash
          # Print the actual different contents of each json file
          # if they don't match.
          ref_contents = reference_snapshot[:contents][file].flatten
          new_contents = new_snapshot[:contents][file].flatten
          expect(new_contents).to match_array(ref_contents), "#{file} (flattened)"
        else
          expect(new_hash).to eq(ref_hash), file.to_s
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
          file_contents = zip.get_input_stream(entry).read.force_encoding('UTF-8')
          digest_contents[:hashes][file_name] = Digest::MD5.hexdigest(file_contents)
          next unless file_name.ends_with?('.json')

          digest_contents[:contents][file_name] = JSON.parse(file_contents)
        end
      end
    end
    digest_contents
  end
end
