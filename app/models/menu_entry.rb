class MenuEntry < ActiveRecord::Base
  has_many :pages
  attr_accessible :title, :position, :permalink

  before_save :generate_permalink

  default_scope :order => 'position ASC'

  def generate_permalink
    self.permalink = title.downcase.gsub(/ +/,'_') unless title.nil?
  end
end

