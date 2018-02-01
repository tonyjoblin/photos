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
    # TODO: this only needs to be once off setup code
    # not every call to create
    create_uploads_folder_if_not_exist

    @create_errors = []
    @create_success = []
    images = image_params
    description = text_params
    images.each do |image|
      unless content_type_is_valid? image.content_type
        @create_errors.push(invalid_mime_type_msg(image))
        next
      end
      # render :bad_request unless uploaded_io # TODO fix
      # TODO check max image sizes
      # TODO check max image uploads
      # TODO handle more than one image upload
      create_and_store_image image, description[:caption], description[:story]
      @create_success.push create_ok_msg(image)
    end

    if @create_errors.empty?
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

  def create_ok_msg(image)
    "The image #{image.original_filename} was successfully uploaded."
  end

  def invalid_mime_type_msg(image)
    "The image #{image.original_filename} has an invalid mime type of #{image.content_type}."
  end

  def create_and_store_image(image, caption, story)
    file_name = random_filename image
    upload_photo image_pathname(file_name), image

    @photo = Photo.new
    @photo.original_name = image.original_filename
    @photo.file_name = file_name
    @photo.caption = caption
    @photo.story = story
    @photo.save!
  end

  def content_type_is_valid?(content_type)
    allowed_mimetypes.include? content_type
  end

  def allowed_mimetypes
    ['image/jpeg', 'image/png']
  end

  def image_params
    params.require(:image_uploads)
  end

  def text_params
    params.require(:photo).permit(:caption, :story)
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
