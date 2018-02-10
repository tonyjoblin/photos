class AddSizeToPhoto < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :size, :number
    change_column_null :photos, :size, false
  end
end
