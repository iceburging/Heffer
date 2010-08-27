class Country < ActiveRecord::Base
  has_and_belongs_to_many :shipping_methods

  attr_accessible :name, :iso_code
end

