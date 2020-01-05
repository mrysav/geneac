# frozen_string_literal: true

require 'test_helper'

# Tests basic snapshot creation via job
class CreateSnapshotJobTest < ActiveJob::TestCase
  test 'snapshot creation correctly uploads a file' do
    pre_count = Snapshot.count
    CreateSnapshotJob.perform_now
    assert_equal pre_count + 1, Snapshot.count
  end
end
