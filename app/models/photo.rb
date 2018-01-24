# Photo model
# The details of each uploaded photo
class Photo < ApplicationRecord
  validates :file_name, presence: true
  validates :original_name, presence: true

  attr_accessor :url
end
