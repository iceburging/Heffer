class Mailer < ActionMailer::Base

  helper :application

  # customer emails

  def dispatch_of_order(order)
    recipients order.billing_email
    from "notification@#{DOMAIN}"
    subject "Order dispatched (#{order.order_number})"
    body :order => order
    content_type "text/html"
  end

  def confirmation_of_order(order)
    recipients order.billing_email
    from "notification@#{DOMAIN}"
    subject "Order confirmation (#{order.order_number})"
    body :order => order
    content_type "text/html"
  end

end

