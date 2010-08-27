class Option < ActiveRecord::Base
  belongs_to :product_line

  attr_accessible :product_line, :size, :colour, :available, :remove

  attr_accessor :remove

  def remove?
    @remove == '1' ? true : false
  end

  def name
    name = []
    name << size
    name << colour
    name.compact!
    name.join(' ')
  end
end

