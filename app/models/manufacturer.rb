class Manufacturer < ActiveRecord::Base
  has_many :product_lines

  attr_accessible :name, :telephone, :contact, :account
end

