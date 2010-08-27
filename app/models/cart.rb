class Cart

  attr_reader :items

  def initialize
    @items = []
  end

  def add_item(option,quantity)
    item = @items.find {|item| item.option == option}
    if item
      item.increment_quantity(quantity)
    else
      @items << Item.new(option,quantity)
    end
  end

  def update_item(option,quantity)
    item = @items.find {|item| item.option == option}
    item.set_quantity(quantity) if item
  end

  def remove_item(option)
    item = @items.find {|item| item.option == option}
    @items.delete(item)
  end

  def empty
    @items = []
  end

  def is_empty?
    populated_items = @items.find {|item| item.quantity > 0}
    populated_items.nil?
  end

  def count
    @items.reduce(0){|total,item| total =+ item.quantity}
  end

end

