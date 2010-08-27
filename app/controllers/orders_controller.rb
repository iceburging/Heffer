class OrdersController < PrivateController

  def active
    @checked = Order.active.find(:all, :conditions => {:status => 'checked'})
    @authenticated = Order.active.find(:all, :conditions => {:status => 'authenticated'})
    @authorized = Order.active.find(:all, :conditions => {:status => 'authorized'})
    @captured = Order.active.find(:all, :conditions => {:status => 'captured'})
  end

  def completed
    @dispatched = Order.active.find(:all, :conditions => {:status => 'dispatched'})
    @refunded = Order.active.find(:all, :conditions => {:status => 'credited'})
    @voided = Order.active.find(:all, :conditions => {:status => 'voided'})
  end

  def inactive
    @inactive = Order.find(:all,:conditions => {:active => false})
  end

  def show
    @order = Order.find(params[:id])
    prawnto :prawn => {:skip_page_creation=>true}
    respond_to do |format|
      format.html # index.html.erb
      format.pdf { render :layout => false }
    end
  end

  def new
    retrieve_order

    if @order.cart.is_empty?
      render :empty_cart
    else
      @shipping_method = @order.shipping_method
      render :new
    end
  end

  def update_order
    retrieve_order

    if params[:cart]
      params[:cart][:items].each do |item|
        @order.cart.update_item(Option.find(item['option_id']),item['quantity'].to_i)
      end
    end

    if params[:shipping_method]
      @order.shipping_method = ShippingMethod.new(params[:shipping_method])
    end

    @order.attributes = params[:order] # may need to update @cart variable after doing this
    redirect_to :action => :new
  end

  def remove_from_cart
    retrieve_order
    @order.cart.remove_item(Option.find(params[:item_id]))
    redirect_to :action => :new
  end

  def create
    retrieve_order
    @order.enrollment_check_response = ActiveMerchant::Billing::PayflowUKCardinalResponse.new({:error_no =>'0'})
    @order.authorize_response = ActiveMerchant::Billing::Response.new(true,'Manually authorized')
    #@order.enrollment_check_called_at =
    @order.authorize_called_at = DateTime.now
    params[:order][:transaction_type] << '(Manual)'
    @order.attributes = params[:order]
    @order.save(false)
    @order.clear_card_data
    session[:order] = nil
    redirect_to @order
  end

  def edit
  end

  def update
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    flash[:notice] = "Successfully destroyed order."
    redirect_to :back
  end

  def refund
    @order = Order.find(params[:id])
    if params[:amount].nil?
      flash[:notice] = 'Please specify a refund value greater than zero'
      redirect_to :action => 'show', :id => params[:id]
    else
      if @order.credit(params[:amount])
        flash[:notice] = 'Order refunded'
        redirect_to :action => 'show', :id => params[:id]
      else
        flash[:notice] = 'Order refund failed'
        redirect_to :action => 'show', :id => params[:id]
      end
    end
  end

  def void
    @order = Order.find(params[:id])
    if @order.void
      flash[:notice] = 'Order voided'
      redirect_to :action => 'show', :id => params[:id]
    else
      flash[:notice] = 'Order voiding failed'
      redirect_to :action => 'show', :id => params[:id]
    end
  end

  def dispatch
    @order = Order.find(params[:id])
    @order.dispatch
    flash[:notice] = 'Order dispatch notice sent'
    redirect_to :action => 'show', :id => params[:id]
  end

  def capture
    @order = Order.find(params[:id])
    if @order.capture
      flash[:notice] = 'Order captured'
      redirect_to :action => 'show', :id => params[:id]
    else
      flash[:notice] = 'Order capture failed'
      redirect_to :action => 'show', :id => params[:id]
    end
  end

end

