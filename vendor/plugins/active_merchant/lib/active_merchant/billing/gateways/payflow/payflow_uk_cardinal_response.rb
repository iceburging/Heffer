module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    class PayflowUKCardinalResponse

    attr_reader :params, :message, :test, :transaction_id

      def attributes
        hash = {}
        self.instance_variables.each do |var|
          hash[:"#{var.gsub('@','')}"]=self.instance_variable_get(var)
        end
        return hash
      end

      def success?
        if !params.nil?
          true ? params['error_no'] == '0' : false
        else
          false
        end
      end

      def test?
        @test
      end

      def message
        if !params.nil?
          params['error_desc']
        else
          ''
        end
      end

      def initialize(params = {}, options = {})
        @params = params.stringify_keys if !params.nil?
        @test = options[:test] || false
        @transaction_id = options[:transaction_id] if !options[:transaction_id].nil?
      end
    end
  end
end

