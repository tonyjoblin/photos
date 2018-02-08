class AddContentTypeToPhotos < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :content_type, :string
    change_column_null :photos, :content_type, false
  end
end
