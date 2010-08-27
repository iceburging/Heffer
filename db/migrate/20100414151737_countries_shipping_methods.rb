class CountriesShippingMethods < ActiveRecord::Migration
  def self.up
    create_table :countries_shipping_methods, :id => false do |t|
      t.column :country_id, :integer
      t.column :shipping_method_id, :integer
    end
  end

  def self.down
    drop_table :countries_shipping_methods
  end
end

