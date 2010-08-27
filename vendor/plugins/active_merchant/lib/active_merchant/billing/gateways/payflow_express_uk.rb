require File.dirname(__FILE__) + '/payflow_express'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    class PayflowExpressUkGateway < PayflowExpressGateway
      self.default_currency = 'GBP'
      self.partner = 'PayPalUk'
      self.test_redirect_url = 'https://www.sandbox.paypal.com/webscr?cmd=_express-checkout&token='

      self.supported_countries = ['GB']
      self.homepage_url = 'https://www.paypal.com/uk/webscr?cmd=_additional-payment-overview-outside'
      self.display_name = 'PayPal Express Checkout (UK)'
    end
  end
end

