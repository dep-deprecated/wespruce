class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :owner_id
      t.string :owner_type
      t.string :kind

      t.timestamps
    end
  end
end
