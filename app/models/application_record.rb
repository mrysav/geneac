# frozen_string_literal: true

# Parent class of all ActiveRecord objects
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.drop_em_all!
    find_each(&:destroy!)
    update_seq!
  end

  def self.update_seq!
    ActiveRecord::Base.connection.execute(
      "UPDATE sqlite_sequence SET seq = (SELECT MAX(#{primary_key}) FROM #{table_name}) WHERE name = '#{table_name}'"
    )
  end
end
