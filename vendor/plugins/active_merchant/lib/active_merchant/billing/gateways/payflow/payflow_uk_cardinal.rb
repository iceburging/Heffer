require File.dirname(__FILE__) + '/payflow_uk_cardinal_response'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
      module PayflowUkCardinal

        TEST_AUTH_URL = 'https://centineltest.cardinalcommerce.com/maps/txns.asp'
        LIVE_AUTH_URL = 'https://paypal.cardinalcommerce.com/maps/txns.asp'

        TRANSACTIONS = {
          :purchase       => "Sale",
          :authorization  => "Authorization",
          :capture        => "Capture",
          :void           => "Void",
          :credit         => "Credit"
        }

        # performs lookup and returns response
        def request_auth_status(money, credit_card, options = {})
          request = build_auth_status_request(money, credit_card, options) # create the XML status request
          commit_auth(request)
        end

        def authenticate(options = {})
          request = build_authentication_request(options)
          commit_auth(request)
        end

        private
        def build_auth_status_request(money, credit_card, options)
          xml = Builder::XmlMarkup.new
          xml.tag! 'CardinalMPI' do
            xml.tag! 'MsgType', 'cmpi_lookup'
            xml.tag! 'Version', '1.7'
            xml.tag! 'ProcessorId', @options[:login_pid_auth]
            xml.tag! 'MerchantId', @options[:login_mid_auth]
            xml.tag! 'TransactionPwd', @options[:password_auth]
            xml.tag! 'TransactionType', 'C'
            xml.tag! 'Amount', "%i" % money unless money.blank?
            xml.tag! 'CurrencyCode', '826'
            xml.tag! 'CardNumber', credit_card.number unless credit_card.number.blank?
            xml.tag! 'CardExpMonth', "%02i" % credit_card.month unless credit_card.month.blank?
            xml.tag! 'CardExpYear', credit_card.year unless credit_card.year.blank?
            xml.tag! 'OrderNumber', options[:order_number] unless options[:order_number].blank?
            xml.tag! 'OrderDescription', options[:order_description] unless options[:order_description].blank?
            xml.tag! 'EMail', options[:email] unless options[:email].blank?
            xml.tag! 'IPAddress', options[:ip_address] unless options[:ip_address].blank?
          end
          xml.target!
        end

        def build_authentication_request(options)
          xml = Builder::XmlMarkup.new
          xml.tag! 'CardinalMPI' do
            xml.tag! 'MsgType', 'cmpi_authenticate'
            xml.tag! 'Version', '1.7'
            xml.tag! 'ProcessorId', @options[:login_pid_auth]
            xml.tag! 'MerchantId', @options[:login_mid_auth]
            xml.tag! 'TransactionPwd', @options[:password_auth]
            xml.tag! 'TransactionType', 'C'
            xml.tag! 'TransactionId', options[:transaction_id] unless options[:transaction_id].blank?
            xml.tag! 'PAResPayload', options[:pares] unless options[:pares].blank?
          end
          xml.target!
        end

        def build_credit_card_request(action, money, credit_card, options)
        xml = Builder::XmlMarkup.new
        xml.tag! TRANSACTIONS[action] do
          xml.tag! 'PayData' do
            xml.tag! 'Invoice' do
              xml.tag! 'CustIP', options[:ip] unless options[:ip].blank?
              xml.tag! 'InvNum', options[:order_id].to_s.gsub(/[^\w.]/, '') unless options[:order_id].blank?
              xml.tag! 'Description', options[:description] unless options[:description].blank?
              xml.tag! 'Comment', options[:comment1] unless options[:comment1].blank?
              xml.tag! 'Comment', options[:comment2] unless options[:comment2].blank?

              billing_address = options[:billing_address] || options[:address]
              add_address(xml, 'BillTo', billing_address, options) if billing_address
              shipping_address = options[:shipping_address] || options[:address]
              add_address(xml, 'ShipTo', shipping_address, options) if shipping_address

              xml.tag! 'TotalAmt', amount(money), 'Currency' => options[:currency] || currency(money)
              xml.tag! 'TaxAmt', amount(options[:tax_amt])
              xml.tag! 'ItemAmt', amount(options[:items_amt])
              xml.tag! 'ShippingtAmt', amount(options[:shipping_amt])
            end

            xml.tag! 'Tender' do
              #puts "auth_status_3ds: #{options[:auth_status_3ds]}, mpi_vendor_3ds: #{options[:mpi_vendor_3ds]}, cavv: #{options[:cavv]}, eci: #{options[:eci]},  xid: #{options[:xid]}"
              # sending additional authentication fields regardless of enrollment as per pp instructions
              #if options[:auth_status_3ds] && options[:mpi_vendor_3ds] && options[:cavv] && options[:eci] && options[:xid]
                add_authenticated_credit_card(xml, credit_card, options)
              #else
              #  add_credit_card(xml, credit_card)
              #end
            end
          end
        end
        xml.target!
      end

        def add_authenticated_credit_card(xml, credit_card, options)
          xml.tag! 'Card' do
            xml.tag! 'CardType', credit_card_type(credit_card)
            xml.tag! 'CardNum', credit_card.number
            xml.tag! 'ExpDate', expdate(credit_card)
            xml.tag! 'NameOnCard', credit_card.first_name
            xml.tag! 'CVNum', credit_card.verification_value if credit_card.verification_value?

            xml.tag! 'BuyerAuthResult' do
              xml.tag! 'AUTHSTATUS3DS', options[:auth_status_3ds] if !options[:auth_status_3ds].nil?
              xml.tag! 'MPIVENDOR3DS', options[:mpi_vendor_3ds] if !options[:mpi_vendor_3ds].nil?
              xml.tag! 'ECI3DS', options[:eci] if !options[:eci].nil?
              xml.tag! 'CAVV', options[:cavv] if !options[:cavv].nil?
              xml.tag! 'XID', options[:xid] if !options[:xid].nil?
            end

            if requires_start_date_or_issue_number?(credit_card)
              xml.tag!('ExtData', 'Name' => 'CardStart', 'Value' => startdate(credit_card)) unless credit_card.start_month.blank? || credit_card.start_year.blank?
              xml.tag!('ExtData', 'Name' => 'CardIssue', 'Value' => format(credit_card.issue_number, :two_digits)) unless credit_card.issue_number.blank?
            end
            xml.tag! 'ExtData', 'Name' => 'LASTNAME', 'Value' =>  credit_card.last_name
          end
        end

        def commit_auth(request_body, request_type = nil)
          request = build_auth_request(request_body)
          headers = build_auth_headers

      	  response = parse_auth(ssl_post(test? ? TEST_AUTH_URL : LIVE_AUTH_URL, request, headers))

          ###########################################################
          #    Break compound line to enable debuging on console    #
          ###########################################################

          #puts "REQUEST: #{request}"
          #r1 = ssl_post(test? ? TEST_AUTH_URL : LIVE_AUTH_URL, request, headers)
          #puts "RESPONSE STRING: #{r1}"
          #response = parse_auth(r1)



      	  build_auth_response(response,{:test => test?,:transaction_id => response[:transaction_id]})
        end

        def build_auth_response(response, options = {})
          PayflowUKCardinalResponse.new(response, options)
        end

        def parse_auth(data)
          response = {}
          xml = REXML::Document.new(data)
          root = REXML::XPath.first(xml, "//CardinalMPI")

          root.elements.to_a.each do |node|
            parse_element(response, node)
          end

          response
        end

        def build_auth_request(body)
          "cmpi_msg=#{CGI::escape(body)}"
        end

        def build_auth_headers
          {
            "Content-Type" => "application/x-www-form-urlencoded"
      	  }
      	end

      end
  end
end

