module CheckoutHelper

  def get_active_countries
    Country.find(:all,:include => :shipping_methods, :conditions => "shipping_methods.id IS NOT NULL")
  end

  def get_valid_shipping_methods
    Country.find_by_name(@order.delivery_country).shipping_methods
  end

end

