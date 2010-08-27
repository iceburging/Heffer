class Category < ActiveRecord::Base
  has_many :product_lines
  has_many :flags, :through => :product_lines

  attr_accessible :position, :title, :blurb, :permalink

  before_save :generate_permalink

  default_scope :order => 'position ASC'

  def generate_permalink
    self.permalink = title.downcase.gsub(/ +/,'_') unless title.nil?
  end
end

