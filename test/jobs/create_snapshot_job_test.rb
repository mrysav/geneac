# frozen_string_literal: true

require 'test_helper'

# Tests basic snapshot creation via job
class CreateSnapshotJobTest < ActiveJob::TestCase
  test 'snapshot creation correctly uploads a file' do
    person = people(:ross)
    person.save!

    assert Snapshot.count.zero?
    CreateSnapshotJob.perform_now
    assert Snapshot.count == 1
  end
end
