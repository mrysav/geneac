require 'test_helper'

class ApplicationRecordTest < ActiveSupport::TestCase
  test 'person model inherits drop_em_all! method' do
    ross = Person.new(first_name: 'Ross', last_name: 'Geller')
    ross.save!

    assert Person.count > 0
    refute_nil ross.id

    Person.drop_em_all!

    assert_equal 0, Person.count

    rachel = Person.new(first_name: 'Rachel', last_name: 'Green')
    rachel.save!

    assert_equal 1, Person.count
    assert_equal 1, rachel.id
  end
end