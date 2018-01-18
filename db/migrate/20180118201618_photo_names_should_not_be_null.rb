class PhotoNamesShouldNotBeNull < ActiveRecord::Migration[5.1]
  def change
    change_column_null :photos, :original_name, false
    change_column_null :photos, :file_name, false
  end
end
