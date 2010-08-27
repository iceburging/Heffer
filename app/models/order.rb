class Order < ActiveRecord::Base
  serialize :cart
  serialize :enrollment_check_response
  serialize :authenticate_response
  serialize :authorize_response
  serialize :capture_response
  serialize :void_response
  serialize :credit_response

  before_save :set_status

  named_scope :active, :conditions => {:active => true}

  attr_accessor :card_number, :card_type, :card_start_date, :card_expiry_date, :card_verification_value, :card_issue_number, :shipping_method

  # hack to enable multi attribute date behaviour on virtual attributes #

  columns_hash["card_start_date"] = ActiveRecord::ConnectionAdapters::Column.new("card_start_date", nil, "date")
  columns_hash["card_expiry_date"] = ActiveRecord::ConnectionAdapters::Column.new("card_expiry_date", nil, "date")

  #  -- end -- #

  attr_accessible :transaction_type, :discount_description, :discount_value, :order_credit, :active, :order_ref, :shipping_method, :cart, :card_number, :card_type, :card_start_date, :card_expiry_date, :card_verification_value, :card_issue_number, :billing_email, :billing_telephone_number, :billing_firstname, :billing_lastname, :billing_line1, :billing_line2, :billing_town, :billing_county, :billing_country, :billing_postcode, :delivery_firstname, :delivery_lastname, :delivery_line1, :delivery_line2, :delivery_town, :delivery_county, :delivery_country, :delivery_postcode

  validation_group :cart_and_shipping do
    validates_presence_of :cart
    validates_presence_of :shipping_method
  end

  validation_group :delivery_address do
    validates_presence_of :delivery_firstname
    validates_presence_of :delivery_lastname
    validates_presence_of :delivery_line1
    validates_presence_of :delivery_town
    validates_presence_of :delivery_county
    validates_presence_of :delivery_country
  end

  validation_group :billing_address do
    validates_presence_of :billing_firstname
    validates_presence_of :billing_lastname
    validates_presence_of :billing_line1
    validates_presence_of :billing_town
    validates_presence_of :billing_county
    validates_presence_of :billing_country
  end

  validation_group :contact_details do
    validates_presence_of :billing_email
    validates_presence_of :billing_telephone_number
  end

  def shipping_method # cannot directly serialize AR object
    require_dependency 'shipping_method' # to ensure object is known to YAML
    if read_attribute(:shipping_method)
      YAML::load(read_attribute(:shipping_method))
    else
      nil
    end
  end

  def shipping_method=(object)
    write_attribute(:shipping_method, YAML::dump(object))
  end

  def manual?
    transaction_type.try(:include?,'(Manual)') ? true : false
  end

  def has_items?
    false
  end

  def subtotal
    cart.items.reduce(0){|subtotal,item| subtotal += item.option.product_line.price * item.quantity}
  end

  def total
    subtotal + ( shipping_method.try(:price) || 0 ) - ( discount_value || 0 )
  end

  def total_as_int
    (total*100).to_i
  end

  def credit_card
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
      :type               => card_type,
      :number             => card_number,
      :verification_value => card_verification_value,
      :month              => card_expiry_date.try(:month),
      :year               => card_expiry_date.try(:year),
      :start_month        => card_start_date.try(:month),
      :start_year         => card_start_date.try(:year),
      :first_name         => billing_firstname,
      :last_name          => billing_lastname,
      :issue_number       => card_issue_number
    )
  end

  def order_number
    created_at.to_f.to_s.sub('.','').to_i.to_s(2).scan(/..../).map{|b| sprintf('%x','0b'+b)}.join.upcase
  end

  def clear_card_data
    self.card_type = nil
    self.card_number = nil
    self.card_verification_value = nil
    self.card_expiry_date = nil
    self.card_start_date = nil
    self.card_issue_number = nil
    self.save(false)
  end

  def get_status
    return 'credited' if credit_response.try(:success?)
    return 'voided' if void_response.try(:success?)
    return 'dispatched' if dispatch_called_at
    return 'captured' if capture_response.try(:success?)
    return 'authorized' if authorize_response.try(:success?)
    return 'authenticated' if authenticate_response.try(:success?)
    return 'checked' if enrollment_check_response.try(:success?)
    return ''
  end

  def set_status
    self.status = get_status
  end

  def value
    order_credit.nil? ? total : (total - order_credit)
  end

  def delivery_address
    address = []
    name = []
    name << delivery_firstname if !delivery_firstname.blank?
    name << delivery_lastname if !delivery_lastname.blank?
    address << name.compact.join(' ')
    address << delivery_line1 if !delivery_line1.blank?
    address << delivery_line2 if !delivery_line2.blank?
    address << delivery_town if !delivery_town.blank?
    address << delivery_county if ! delivery_county.blank?
    address << delivery_country if !delivery_country.blank?
    address << delivery_postcode if !delivery_postcode.blank?
    return address
  end

  def billing_address
    address = []
    name = []
    name << billing_firstname if !billing_firstname.blank?
    name << billing_lastname if !billing_lastname.blank?
    address << name.compact.join(' ')
    address << billing_line1 if !billing_line1.blank?
    address << billing_line2 if !billing_line2.blank?
    address << billing_town if !billing_town.blank?
    address << billing_county if ! billing_county.blank?
    address << billing_country if !billing_country.blank?
    address << billing_postcode if !billing_postcode.blank?
    return address
  end

# payment methods

  def retrieve_details_express
    details = GATEWAY.express.details_for(order_ref)
    #-----
    self.delivery_firstname = (details.params['name'] || '').titleize
    self.delivery_lastname = (details.params['lastname'] || '').titleize
    self.delivery_line1 = (details.params['street'] || '').titleize
    self.delivery_line2 = (details.params['shiptostreet2'] || '').titleize
    self.delivery_town = (details.params['city'] || '').titleize
    self.delivery_county = (details.params['state'] || '').titleize
    self.delivery_postcode = (details.params['zip'] || '').upcase
    self.delivery_country = (details.params['country'] || '').upcase
    #-----
    self.billing_firstname = (details.params['name'] || '').titleize
    self.billing_lastname = (details.params['lastname'] || '').titleize
    self.billing_line1 = (details.params['street'] || '').titleize
    self.billing_line2 = (details.params['shiptostreet2'] || '').titleize
    self.billing_town = (details.params['city'] || '').titleize
    self.billing_county = (details.params['state'] || '').titleize
    self.billing_postcode = (details.params['zip'] || '').upcase
    self.billing_country = (details.params['country'] || '').upcase
    #-----
    self.billing_email = details.params['e_mail'] || ''
    self.billing_telephone_number = details.params['telephone'] || '' # will need changing
    #-----
    self.save(false)
  end

  def express_authentication(return_url, cancel_url)
    options = {:return_url => return_url, :cancel_return_url => cancel_url, :ip => ip_address}
    response = GATEWAY.express.setup_authorization(total_as_int, options)
    self.order_ref = response.token if response.success?
    self.authenticate_response = response
    self.authenticate_called_at = DateTime.now
    self.save(false)
    response.success?
  end

  def express_authorization(id)
    response = GATEWAY.express.authorize(total_as_int, {:token => order_ref, :payer_id => id})
    self.authorize_response = response
    self.authorize_called_at = DateTime.now
    self.save(false)
    response.success?
  end

  def authenticate(pares)
    response = GATEWAY.authenticate({:transaction_id => enrollment_check_response.params['transaction_id'],:pares => pares})
    self.authenticate_response = response
    self.authenticate_called_at = DateTime.now
    self.save(false)
    response.success?
  end

  def enrollment_check
    response = GATEWAY.request_auth_status(total_as_int, credit_card, {:order_number => order_number, :ip_address => ip_address})
    self.enrollment_check_response = response
    self.enrollment_check_called_at = DateTime.now
    self.save(false)
    response.params['enrolled']
  end

  def authorize
    authenticate_options = {:auth_status_3ds => '', :mpi_vendor_3ds => '', :cavv => '', :eci => '', :xid => ''}
    if self.authenticate_response
      authenticate_options[:auth_status_3ds] = self.authenticate_response.params['pa_res_status'] || ''
      authenticate_options[:mpi_vendor_3ds] = self.enrollment_check_response.params['enrolled'] || ''
      authenticate_options[:cavv] = self.authenticate_response.params['cavv'] || ''
      authenticate_options[:eci] = self.authenticate_response.params['eci_flag'] || ''
      authenticate_options[:xid] = self.authenticate_response.params['xid'] || ''
    end
    response = GATEWAY.authorize(total_as_int, credit_card, purchase_options.merge(authenticate_options))
    self.authorize_response = response
    self.authorize_called_at = DateTime.now
    self.save(false)
    response.success?
  end

  def capture
    if manual?
      response = ActiveMerchant::Billing::Response.new(true,'Manually captured')
    else
      response = GATEWAY.capture(total_as_int, authorize_response.authorization)
    end
    self.capture_response = response
    self.capture_called_at = DateTime.now
    self.save(false)
    response.success?
  end

  def dispatch
    Mailer.deliver_dispatch_of_order(self)
    self.dispatch_called_at = DateTime.now
    self.save(false)
  end

  def credit(amount)
    amount_as_int = (amount.to_d * 100).to_i
    if amount_as_int > total_as_int
      return false
    else
      if manual?
        response = ActiveMerchant::Billing::Response.new(true,'Manually credited')
      else
        response = GATEWAY.credit(amount_as_int, capture_response.authorization)
      end
      self.credit_response = response
      self.credit_called_at = DateTime.now
      self.order_credit = amount if response.success?
      self.save(false)
      response.success?
    end
  end

  def void
    if manual?
      response = ActiveMerchant::Billing::Response.new(true,'Manually voided')
    else
      response = GATEWAY.void(authorize_response.authorization)
    end
    self.void_response = response
    self.void_called_at = DateTime.now
    self.save(false)
    response.success?
  end

private

  def purchase_options
    { :billing_address => { :name => "#{billing_firstname} #{billing_lastname}",
                               :address1 => [billing_line1, billing_line2].join(', '),
                               :city => billing_town,
                               :state => billing_county,
                               :country => Country.find_by_name(billing_country).iso_code,
                               :zip => billing_postcode},
      :shipping_address => { :name => "#{delivery_firstname} #{delivery_lastname}",
                               :address1 => [delivery_line1, delivery_line2].join(', '),
                               :city => delivery_town,
                               :state => delivery_county,
                               :country => Country.find_by_name(delivery_country).iso_code,
                               :zip => delivery_postcode},
      :phone => billing_telephone_number,
      :email => billing_email,
      :order_id => order_number,
      :ip => ip_address
    }
  end

end

