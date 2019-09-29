# frozen_string_literal: true

require 'test_helper'

# Tests that various snapshot functionality works
class SnapshotTest < ActiveSupport::TestCase
  test 'snapshot creation works' do
    snapshot = Snapshot.new
    file = File.open Rails.root.join('test', 'fixtures', 'files', 'test_snapshot.zip')
    snapshot.archive.attach(io: file, filename: 'test_snapshot.zip')
    snapshot.save!
  end
end
