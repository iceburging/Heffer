class Page < ActiveRecord::Base
  belongs_to :menu_entry
  attr_accessible :menu_entry_id, :position, :title, :content, :menu_entry, :permalink

  before_save :generate_permalink

  default_scope :order => 'position ASC'

  def generate_permalink
    self.permalink = title.downcase.gsub(/ +/,'_') unless title.nil?
  end
end

