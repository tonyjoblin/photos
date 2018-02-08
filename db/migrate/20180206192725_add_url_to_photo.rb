class AddUrlToPhoto < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :url, :string
    change_column_null :photos, :url, false
  end
end
