class FlagsProductLines < ActiveRecord::Migration
  def self.up
    create_table :flags_product_lines, :id => false do |t|
      t.column :flag_id, :integer
      t.column :product_line_id, :integer
    end
  end

  def self.down
    drop_table :flags_product_lines
  end
end

