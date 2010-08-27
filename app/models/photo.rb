require 'colourspace' # customised image operator

class Photo < ActiveRecord::Base
  belongs_to :product_line
  attr_accessible :title, :image_file, :product_line_id, :position, :product_line

  default_scope :order => 'position ASC'

  acts_as_fleximage do
    image_directory 'public/images/products'
    output_image_jpg_quality 85
    preprocess_image do |image|
      image.resize '300x500'
      image.colourspace
    end
  end
end

