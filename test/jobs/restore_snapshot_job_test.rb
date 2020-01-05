require 'test_helper'

# Very expensive test that does the job of testing snapshot restoration
class RestoreSnapshotJobTest < ActiveJob::TestCase
  test 'serialized copy of test database matches restored copy' do
    tables_to_check = [Person, Note, Photo, Fact]
    serialized_db = serialize_all(tables_to_check)
    CreateSnapshotJob.perform_now

    tables_to_check.each(&:drop_em_all!)
    tables_to_check.each do |table|
      assert_equal 0, table.count
    end


    RestoreSnapshotJob.perform_now(Snapshot.order(:created_at).last)
    post_restore_serialized_db = serialize_all(tables_to_check)
    assert_equal serialized_db, post_restore_serialized_db
  end

  def serialize_all(model_classes)
    out = {}
    model_classes.each do |model_class|
      out[model_class.to_s] = model_class.all.to_json
    end
    out
  end
end
