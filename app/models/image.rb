require 'colourspace' # customised image operator

class Image < ActiveRecord::Base
  attr_accessible :title, :tag, :image_file

  validates_uniqueness_of :tag

  acts_as_fleximage do
    image_directory'public/images/site'
    preprocess_image do |image|
      image.colourspace
    end
  end
end

