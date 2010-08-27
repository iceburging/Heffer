class CreateOptions < ActiveRecord::Migration
  def self.up
    create_table :options do |t|
      t.belongs_to :product_line
      t.string :size
      t.string :colour
      t.boolean :available
      t.timestamps
    end
  end

  def self.down
    drop_table :options
  end
end

