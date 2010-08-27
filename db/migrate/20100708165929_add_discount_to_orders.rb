class AddDiscountToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :discount_value, :decimal, :precision => 10, :scale => 2
    add_column :orders, :discount_description, :string
  end

  def self.down
    remove_column :orders, :discount_value
    remove_column :orders, :discount_description
  end
end

