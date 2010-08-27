class CreateMenuEntries < ActiveRecord::Migration
  def self.up
    create_table :menu_entries do |t|
      t.string :title
      t.integer :position
      t.timestamps
    end
  end
  
  def self.down
    drop_table :menu_entries
  end
end
