require 'test_helper'

class MockUpload < StringIO
  attr_accessor :original_filename
end

class PhotosControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get photos_url
    assert_response :success
  end
  test 'should get new photo' do
    get new_photo_url
    assert_response :success
  end
  test 'should create photo' do
    # photo = MockUpload.new('some image data')
    # photo.original_filename = 'cats.jpg'
    # assert_difference('Photo.count') do
    #   post photos_url, params: { image_uploads: photo }
    # end
    # assert_redirected_to photos_path
  end
  test 'create a photo with no params should return error' do
    # post photos_url, params: {}
    # assert_reposnse :error
  end
end
