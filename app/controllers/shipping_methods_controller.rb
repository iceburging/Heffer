class ShippingMethodsController < PrivateController
  def index
    @shipping_methods = ShippingMethod.all
  end

  def show
    @shipping_method = ShippingMethod.find(params[:id])
  end

  def new
    @shipping_method = ShippingMethod.new
  end

  def create
    @shipping_method = ShippingMethod.new(params[:shipping_method])
    if @shipping_method.save
      flash[:notice] = "Successfully created shipping method."
      redirect_to shipping_methods_path
    else
      render :action => 'new'
    end
  end

  def edit
    @shipping_method = ShippingMethod.find(params[:id])
  end

  def update
    @shipping_method = ShippingMethod.find(params[:id])
    if @shipping_method.update_attributes(params[:shipping_method])
      flash[:notice] = "Successfully updated shipping method."
      redirect_to shipping_methods_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @shipping_method = ShippingMethod.find(params[:id])
    @shipping_method.destroy
    flash[:notice] = "Successfully destroyed shipping method."
    redirect_to shipping_methods_url
  end
end

