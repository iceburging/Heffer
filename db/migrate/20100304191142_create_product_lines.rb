class CreateProductLines < ActiveRecord::Migration
  def self.up
    create_table :product_lines do |t|
      t.belongs_to :manufacturer
      t.belongs_to :category
      t.string :mfr_prod_no
      t.text :notes
      t.string :range
      t.string :name
      t.text :description
      t.text :tag_line
      t.string :prod_no
      t.string :fabric
      t.decimal :price, :precision => 10, :scale => 2
      t.timestamps
    end
  end

  def self.down
    drop_table :product_lines
  end
end

