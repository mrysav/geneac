require 'test_helper'

class FactTest < ActiveSupport::TestCase
  test 'fact handles natural dates correctly' do
    fact = facts(:cool_fact)
    assert_nil fact.date
    fact.date_string = '2010-10-31'
    assert_equal 2010, fact.date.year
    fact.date_string = 'October 31st 2010'
    assert_equal 2010, fact.date.year
  end
end
