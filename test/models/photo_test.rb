require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  test 'photo handles natural dates correctly' do
    photo = Photo.new(
      id: 1,
      title: 'Imageless photo',
      description: '*Here we go!*'
    )
    
    assert_nil photo.date
    photo.date_string = '2010-10-31'
    assert_equal 2010, photo.date.year
    photo.date_string = '10/31/2010'
    assert_equal 2010, photo.date.year
  end
end
