require 'securerandom'

# Photos controller
class PhotosController < ApplicationController
  def index
    @photos = Photo.all
  end

  def new
    @photo = Photo.new
  end

  def create
    params_for_create = create_params
    @photo = Photo.create create_params

    upload_photo(params_for_create[:image], @photo.file_name) if @photo.valid?

    if @photo.save
      redirect_to action: 'index'
    else
      render action: 'new'
    end
  end

  def show
    @photo = Photo.find(params[:id])
  end

  private

  def create_params
    params.require(:photo).permit(:caption, :story, :image)
  end

  def upload_photo(from_io, to_file_name)
    uploads_folder = uploads_folder_path
    Dir.mkdir uploads_folder unless Dir.exist? uploads_folder
    to_path = uploads_folder.join(to_file_name)
    File.open(to_path, 'wb') do |file|
      file.write(from_io.read)
    end
  end

  def uploads_folder_path
    Pathname.new('public').join('uploads')
  end
end
