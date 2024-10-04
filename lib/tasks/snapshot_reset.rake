# frozen_string_literal: true

namespace :snapshot do
  desc "Drop all snapshots"
  task reset: :environment do
    Snapshot.find_each(&:destroy!)
    ActiveRecord::Base.connection.reset_pk_sequence!(Snapshot.table_name)
    puts "Dropped all snapshots"
  end
end
