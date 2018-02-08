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
      file_name = random_filename(params[:image])
      Photo.new(
        original_name: params[:image].original_filename,
        file_name: file_name,
        caption: params[:caption],
        story: params[:story],
        url: image_url(file_name),
        content_type: params[:image].content_type
      )
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
