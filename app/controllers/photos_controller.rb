require 'securerandom'

# Photos controller
class PhotosController < ApplicationController
  def index
    @photos = Photo.all
  end

  def new
  end

  def create
    create_uploads_folder_if_not_exist

    file_name = random_filename_for_upload
    uploaded_io = params[:image_uploads]
    upload_photo file_name, uploaded_io

    @photo = Photo.new
    @photo.original_name = uploaded_io.original_filename
    @photo.file_name = file_name
    @photo.save!

    redirect_to action: 'index'
  end

  private

  def upload_photo(to_file_name, from_io)
    File.open(to_file_name, 'wb') do |file|
      file.write(from_io.read)
    end
  end

  def random_filename_for_upload
    File.join uploads_folder_path, SecureRandom.uuid
  end

  def uploads_folder_path
    Rails.root.join('public', 'uploads')
  end

  def create_uploads_folder_if_not_exist
    uploads_folder = uploads_folder_path
    Dir.mkdir uploads_folder unless Dir.exist? uploads_folder
  end
end
