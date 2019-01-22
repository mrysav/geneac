# frozen_string_literal: true

require 'test_helper'

class NoteTest < ActiveSupport::TestCase
  test 'note handles edtf dates correctly' do
    note = notes(:no_date)
    assert_nil note.date
    note.date = '2010-10-31'
    assert_equal 2010, note.date.year
    note.date = '10/31/2010'
    assert_nil note.date
  end
end
