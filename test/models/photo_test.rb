require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  test 'should not save a photo without a file_name' do
    photo = Photo.new
    photo.original_name = 'cats'
    assert_not photo.save, 'saved the photo without a file_name'
  end
  test 'should not save a photo wihtout an original_name' do
    photo = Photo.new
    photo.file_name = '14343441414134'
    assert_not photo.save, 'saved a photo without an original_name'
  end
end
