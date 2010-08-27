class AddPermalinkToMenuEntry < ActiveRecord::Migration
  def self.up
    add_column 'menu_entries', 'permalink', :string
  end

  def self.down
    remove_column 'menu_entries', 'permalink'
  end
end

