# Photo model
# The details of each uploaded photo
class Photo < ApplicationRecord
  validates :file_name, presence: true
  validates :original_name, presence: true
  validates :url, presence: true
  validates :content_type, presence: true

  validates :content_type, inclusion: {
    in: ['image/jpeg', 'image/png', 'image/gif'],
    message: 'The image must be either a jpg, png or gif file.'
  }

  class << self
    def create(params)
      # these are optional so it does not matter if they are nil
      photo = Photo.new(caption: params[:caption], story: params[:story])
      image = params[:image]
      if image
        photo.original_name = image.original_filename
        photo.file_name = random_filename(image)
        photo.url = image_url(photo.file_name)
        photo.content_type = image.content_type
      end
      photo
    end

    private

    def random_filename(image)
      SecureRandom.uuid + Pathname.new(image.original_filename).extname
    end

    def image_url(filename)
      Pathname.new('/uploads').join(filename)
    end
  end
end
