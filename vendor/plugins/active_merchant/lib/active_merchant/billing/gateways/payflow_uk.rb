require File.dirname(__FILE__) + '/payflow'
require File.dirname(__FILE__) + '/payflow_express_uk'
require File.dirname(__FILE__) + '/payflow/payflow_uk_cardinal'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    class PayflowUkGateway < PayflowGateway
      include PayflowUkCardinal

      self.default_currency = 'GBP'
      self.partner = 'PayPalUK'

      def express
        @express ||= PayflowExpressUkGateway.new(@options)
      end

      self.supported_cardtypes = [:visa, :master, :american_express, :discover, :solo, :switch]
      self.supported_countries = ['GB']
      self.homepage_url = 'https://www.paypal.com/uk/cgi-bin/webscr?cmd=_wp-pro-overview-outside'
      self.display_name = 'PayPal Website Payments Pro (UK)'
    end
  end
end

