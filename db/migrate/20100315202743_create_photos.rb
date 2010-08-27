class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.integer :product_line_id
      t.integer :position
      t.string :title
      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end

