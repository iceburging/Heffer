class ProductsController < PublicController
  def list
    if params[:category] != 'all'
      if params[:filter] != 'all'
        @products = ProductLine.find(:all,:joins => [:category, :flags], :conditions => ['categories.permalink = ? AND flags.permalink = ?', params[:category], params[:filter]])
      else
        @products = ProductLine.find(:all,:joins => [:category], :conditions => ['categories.permalink = ?', params[:category]])
      end
    else
      if params[:filter] != 'all'
        @products = ProductLine.find(:all,:joins => [:flags], :conditions => ['flags.permalink = ?', params[:filter]])
      else
        @products = ProductLine.find(:all)
      end
    end
  end

  def details
    @product = ProductLine.find(params[:id])
    if @product.range.blank?
      @range = []
    else
      @range = ProductLine.find(:all,:conditions => {:range => @product.range})
    end
    @item = Item.new
  end

  def add_to_cart
    option = Option.find_by_id(params['option_id'])
    if !option.nil?
      @cart.add_item(Option.find_by_id(params['option_id']),params['quantity'])
      flash[:notice] = "Added #{params['quantity']} item(s) to your cart."
      redirect_to :controller => 'products', :action => 'details', :id => option.product_line.id
    else
      flash[:notice] = "Invalid product please try again."
      redirect_to :controller => 'products', :action => 'list'
    end

  end

end

