class Flag < ActiveRecord::Base
  has_and_belongs_to_many :product_lines

  acts_as_fleximage do
    image_directory 'public/images/site/flags'
    require_image false
  end

  before_save :generate_permalink

  attr_accessible :position, :title, :blurb, :image_file, :permalink

  default_scope :order => 'position ASC'

  def generate_permalink
    self.permalink = title.downcase.gsub(/ +/,'_') unless title.nil?
  end
end

