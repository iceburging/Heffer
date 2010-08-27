class Item

  attr_reader :quantity, :option

  def initialize(option=nil,quantity=1)
    if !option.nil?
      @quantity = quantity.to_i
      @option = option
    end
  end

  def increment_quantity(quantity)
    @quantity += quantity.to_i
  end

  def set_quantity(quantity)
    @quantity = quantity.to_i
  end

  def title
    title = []
    title << option.try(:product_line).try(:manufacturer).try(:name)
    title << option.try(:product_line).try(:name)
    title << option.try(:size)
    title << option.try(:colour)
    title.compact!
    title.join(' ')
  end

  def value
    quantity * option.try(:product_line).try(:price)
  end
end

