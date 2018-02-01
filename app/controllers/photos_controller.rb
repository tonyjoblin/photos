require 'securerandom'

# Photos controller
class PhotosController < ApplicationController
  def index
    @photos = Photo.all
    @photos.each do |p|
      p.url = image_url(p.file_name)
    end
  end

  def new; end

  def create
    create_uploads_folder_if_not_exist

    @create_errors = []
    params = create_params
    image = params[:image]

    @photo = create_photo(params)

    if content_type_is_valid? image.content_type
      upload_photo image_pathname(@photo.file_name), image
    else
      @create_errors.push(invalid_mime_type_msg(image))
      render action: 'new'
      return
    end

    if @photo.save
      redirect_to action: 'index'
    else
      render action: 'new'
    end
  end

  def show
    @photo = Photo.find(params[:id])
    @photo.url = image_url(@photo.file_name)
  end

  private

  # Creates a photo object, but does not save it, then
  # returns it to you.
  def create_photo(params)
    photo = Photo.new
    photo.original_name = params[:image].original_filename
    photo.file_name = random_filename params[:image]
    photo.caption = params[:caption]
    photo.story = params[:story]
    photo
  end

  def invalid_mime_type_msg(image)
    "The image <strong>#{image.original_filename}</strong> has an invalid mime type of #{image.content_type}."
  end

  def content_type_is_valid?(content_type)
    allowed_mimetypes.include? content_type
  end

  def allowed_mimetypes
    ['image/jpeg', 'image/png']
  end

  def create_params
    params.require(:photo).permit(:caption, :story, :image)
  end

  def upload_photo(to_file_name, from_io)
    File.open(to_file_name, 'wb') do |file|
      file.write(from_io.read)
    end
  end

  def random_filename(image)
    ext = Pathname.new(image.original_filename).extname
    SecureRandom.uuid + ext
  end

  def image_url(filename)
    Pathname.new('/uploads').join(filename)
  end

  def uploads_folder_path
    Pathname.new('public').join('uploads')
  end

  def image_pathname(filename)
    uploads_folder_path.join(filename)
  end

  def create_uploads_folder_if_not_exist
    uploads_folder = uploads_folder_path
    Dir.mkdir uploads_folder unless Dir.exist? uploads_folder
  end
end
