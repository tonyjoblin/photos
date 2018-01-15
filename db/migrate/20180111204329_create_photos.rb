class CreatePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :photos do |t|
      t.string :original_name
      t.string :file_name

      t.timestamps
    end
  end
end
