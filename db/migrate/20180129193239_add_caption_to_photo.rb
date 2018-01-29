# This migration adds a caption and story to each photo
class AddCaptionToPhoto < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :caption, :string
    add_column :photos, :story, :text
  end
end
