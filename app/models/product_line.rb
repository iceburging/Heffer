class ProductLine < ActiveRecord::Base
  belongs_to :manufacturer
  has_many :options, :dependent => :destroy
  has_many :photos, :dependent => :destroy
  has_and_belongs_to_many :flags
  belongs_to :category

  accepts_nested_attributes_for :options, :allow_destroy => true

  attr_accessible :manufacturer_id, :category_id, :flag_ids, :mfr_prod_no, :notes, :range, :name, :description, :tag_line, :prod_no, :fabric, :price, :options_attributes

  def self.find_all_available
    product_line_ids = Option.find(:all, :select => 'DISTINCT product_line_id',:joins => [:product_line], :conditions => {:available => true}).map{ |p| p.product_line_id if p.product_line_id }.compact
    ProductLine.find(product_line_ids)
  end

end

