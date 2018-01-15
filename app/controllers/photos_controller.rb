require 'securerandom'

class PhotosController < ApplicationController
  def index
    @photos = Photo.all
  end

  def new
    # byebug
  end

  def create
    byebug

    uploaded_io = params[:image_uploads]
    file_name = Rails.root.join('public', 'uploads', SecureRandom.uuid)
    File.open(file_name, 'wb') do |file|
      file.write(uploaded_io.read)
    end

    @photo = Photo.new
    @photo.original_name = params[:image_uploads].original_filename
    @photo.file_name = file_name
    @photo.save

    render action: "index"
  end
end
