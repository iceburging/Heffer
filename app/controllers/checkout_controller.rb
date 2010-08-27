class CheckoutController < PublicController

  include ApplicationHelper

  skip_before_filter :verify_authenticity_token, :only => :authentication_receive

# Common

  def show_cart
    if @order.cart.is_empty?
      render :empty_cart
    elsif @order.delivery_country.nil?
      redirect_to :action => :edit_country
    else
      @legal = Page.find_by_permalink('legal')
      render :show_cart
    end
  end

  def update_order
    if params[:order][:shipping_method]
      @order.shipping_method = ShippingMethod.find_by_id(params[:order][:shipping_method])
      params[:order].delete(:shipping_method)
    end
    if params[:cart]
      params[:cart][:items].each do |item|
        @order.cart.update_item(Option.find(item['option_id']),item['quantity'].to_i)
      end
    end
    @order.attributes = params[:order] # may need to update @cart variable after doing this
    @order.save(false)
    redirect_to :action => :show_cart
  end

  def empty_cart
    @order.cart.empty  # may need to update @cart variable after doing this
    render :empty_cart
  end

  def remove_from_cart
    @order.cart.remove_item(Option.find(params[:id]))
    redirect_to :action => :show_cart
  end

  def edit_country
    @order.shipping_method = nil # reset since depends on country of delivery
    render :edit_country
  end

  def payment_method
    if !params[:accept].nil?
      if @order.group_valid?(:cart_and_shipping)
        @order.attributes = params[:order]
        @order.save(false) # safe since group_valid performed
        if params[:standard]
          @order.transaction_type = 'Card Payment'
          @order.save(false)
          redirect_to :action => 'delivery_details', :protocol => get_secure_protocol
        else
          @order.transaction_type = 'Paypal Express'
          @order.save(false)
          redirect_to :action => 'express_setup', :protocol => get_secure_protocol
        end
      else
        render :action => 'show_cart'
      end
    else
      flash[:notice] = 'Please agree to our terms and conditions before proceeding to the checkout'
      redirect_to :action => 'show_cart'
    end
  end

# Express

  def express_setup
    if @order.express_authentication(url_for(:controller => 'checkout', :action => 'express_authorize', :only_path => false, :protocol => get_secure_protocol), url_for(:controller => 'checkout', :action => 'express_failed', :only_path => false))
      redirect_to GATEWAY.express.redirect_url_for(@order.order_ref, {:review => false})
    else
      redirect_to :action => 'show_cart'
    end
  end

  def express_authorize
    @order = Order.find(:first, :conditions => {:order_ref => params[:token]})
    @order.retrieve_details_express
    if @order.express_authorization(params[:PayerID])
      Mailer.deliver_confirmation_of_order(@order) # send notification
      flash[:notice] = 'Thank you for your order.'
      redirect_to :action => 'invoice'
    else
      flash[:notice] = 'Sorry we were unable to authorize your payment. Please try again.'
      render :action => 'show_cart'
    end
  end

  def express_failed
    flash[:notice] = 'Sorry but your paypal express order has failed. Please try again or call us for assitance.'
    redirect_to :action => 'show_cart'
  end

# Credit Card

  def delivery_details
    render :delivery_details
  end

  def update_delivery_details
    symbols = [:delivery_firstname, :delivery_lastname, :delivery_line1, :delivery_line2, :delivery_town, :delivery_county, :delivery_postcode]
    keys = params[:order].slice(*symbols)
    keys.each do |key,value|
      new_key = key.to_s.gsub('delivery','billing').to_sym
      params[:order].merge!({new_key.to_sym => value})
    end
    params[:order].merge!({:billing_country => @order.delivery_country})

    @order.attributes = params[:order]

    if @order.groups_valid?(:delivery_address)
      @order.save(false)
      redirect_to :action => 'billing_details', :protocol => get_secure_protocol
    else
      render :delivery_details
    end
  end

  def billing_details
    render :billing_details
  end

  def update_billing_details
    @order.attributes = params[:order]
    if @order.groups_valid?(:billing_address, :contact_details)
      @order.save(false)
      redirect_to :action => 'check_enrollment', :protocol => get_secure_protocol
    else
      render :billing_details
    end
  end

  def check_enrollment
    case @order.enrollment_check
    when 'Y'
      redirect_to :action => 'authentication', :protocol => get_secure_protocol
    when 'N'
      redirect_to :action => 'authorization', :protocol => get_secure_protocol
    when 'U'
      redirect_to :action => 'authorization', :protocol => get_secure_protocol
    else
      @order.clear_card_data
      redirect_to :action => 'billing_details', :protocol => get_secure_protocol
    end
  end

  def authorization
    if @order.authorize
      Mailer.deliver_confirmation_of_order(@order) # send notification
      flash[:notice] = 'Thank you for your order.'
      redirect_to :action => "invoice"
    else
      @order.clear_card_data
      flash[:notice] = 'Sorry we were unable to authorize your payment. Please try again.'
      render :action => 'show_cart'
    end
  end

  def authentication
    render :action => 'authentication'
  end

  def authentication_send
    @acs_url = @order.enrollment_check_response.params['acs_url']
    @pa_req = @order.enrollment_check_response.params['payload']
    @term_url = url_for(:action => 'authentication_receive', :only_path => false, :protocol => get_secure_protocol)
    @order_id = @order.id
    render :action => 'authentication_send', :layout => false
  end

  def authentication_receive
    if params['PaRes'].blank? || params['MD'].blank?
      @order.clear_card_data
      render :text => 'Sorry, an error has occured whilst authenticating your card. This can occur if the forward, back and/or refresh buttons are used during the checkout process. Please try again or call us for assistance.'
    else
      @order = Order.find(params['MD'])
      if @order.authenticate(params['PaRes'])
        case [@order.authenticate_response.params['pa_res_status'],@order.authenticate_response.params['signature_verification']]
        when ['Y','Y']
          render :action => 'authentication_receive', :layout => false
        when ['Y','N']
          @order.clear_card_data
          render :text => 'Sorry, your card has failed authentication. Please try again or call us for assistance.'
        when ['N','Y']
          @order.clear_card_data
          render :text => 'Sorry, your card has failed authentication. Please try again or call us for assistance.'
        when ['A','Y']
          render :action => 'authentication_receive', :layout => false
        when ['U','']
          render :action => 'authentication_receive', :layout => false
        else
          @order.clear_card_data
          render :text => 'Sorry, your card has failed authentication. Please try again or call us for assistance.'
        end
      else
        @order.clear_card_data
        render :text => 'Sorry, an error has occured whilst authenticating your card. Please try again or call us for assistance.'
      end
    end
  end

# Common

  def invoice
    session[:order] = nil
    render :action => 'invoice'
  end


end

