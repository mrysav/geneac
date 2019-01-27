require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  test 'photo handles edtf dates correctly' do
    photo = photos(:no_image)
    assert_nil photo.date
    photo.date = '2010-10-31'
    assert_equal 2010, photo.date.year
    photo.date = '10/31/2010'
    assert_nil photo.date
  end
end
