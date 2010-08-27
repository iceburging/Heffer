class AddPermalinkToFlags < ActiveRecord::Migration
  def self.up
    add_column 'flags', 'permalink', :string
  end

  def self.down
    remove_column 'flags', 'permalink'
  end
end

