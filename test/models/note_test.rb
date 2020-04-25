# frozen_string_literal: true

require 'test_helper'

class NoteTest < ActiveSupport::TestCase
  test 'note handles natural dates correctly' do
    note = build(:note)
    assert_nil note.date
    note.date_string = '2010-10-31'
    assert_equal 2010, note.date.year
    note.date_string = '10/31/2010'
    assert_equal 2010, note.date.year
  end
end
