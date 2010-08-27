class ShippingMethod < ActiveRecord::Base
  has_and_belongs_to_many :countries

  attr_accessible :name, :price, :country_ids
end

