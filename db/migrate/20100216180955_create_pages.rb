class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.integer :menu_entry_id
      t.string :title
      t.integer :position
      t.text :content
      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end

