pdf.start_new_page(:size => 'A4', :layout => :portrait, :top_margin => 50, :bottom_margin => 75)

pdf.text "Dispatch Notice", :size => 30, :style => :bold

pdf.text "Order Date: #{@order.created_at.strftime('%d/%m/%Y')}", :align => :right

pdf.move_down(5)

pdf.text "Order Number: #{@order.order_number}", :align => :right

pdf.move_down(20)

billing_address = @order.billing_address
delivery_address = @order.delivery_address

case billing_address.length <=> delivery_address.length
when 1
  (billing_address.length - delivery_address.length).times {delivery_address << ''}
when -1
  (delivery_address.length - billing_address.length).times {billing_address << ''}
end

pdf.table [["Billing To:","Delivering To:"]], :font_size => 14, :width => 550,  :border_width => 0, :align => { 0 => :left, 1 => :left }

pdf.move_down(10)

pdf.table [billing_address,delivery_address].transpose, :vertical_padding => 0, :position => 30, :width => 550, :border_width => 0, :align => { 0 => :left, 1 => :left }

pdf.move_down(20)

items = @order.cart.items.map do |item|
  [
  item.option.product_line.prod_no,
  item.title,
  item.quantity.to_s,
  number_to_currency(item.option.product_line.price,:unit=>'£')
  ]
end

items << ["",@order.shipping_method.try(:name),"1",number_to_currency(@order.shipping_method.try(:price),:unit=>'£')]
unless @order.discount_value.blank?
  items << ["DISCOUNT >>",@order.discount_description,"",number_to_currency(@order.discount_value,:unit=>'£')]
end
items << [{:text => 'Order Total', :colspan => 3, :align => :right},number_to_currency(@order.total, :unit => '£')]

pdf.table [["Order:"]], :font_size => 14, :width => 550,  :border_width => 0, :align => { 0 => :left}

pdf.move_down(10)

pdf.table items, :border_style => :underline_header, :position => :center,
  :headers => ["Prod No.", "Description", "Qty", "Total Price"],
  :align => { 0 => :left, 1 => :left, 2 => :center, 3 => :right }

pdf.move_down(20)

pdf.text "Many thanks for placing your order with #{SITE_NAME}. We aim to give you excellent quality, service and value and want you to be completely happy with the garment you have purchased. If an item does not fit or you find a fault, you may return it to us within seven days of receipt for a full refund or replacement."

pdf.move_down(10)

pdf.text "To make a return, follow the instructions at www.#{DOMAIN}/returns or call #{RETURNS_NUMBER}. Please do not remove tags from items you wish to return."

pdf.move_down(10)

pdf.text "If you have an idea for a way we can improve our products or our services, please get in touch. Your feedback is very important to us."

pdf.move_down(10)

pdf.text "Regards"

pdf.move_down(10)

pdf.text "#{SIGNEE_NAME} (#{SIGNEE_POSITION})"

