class NewsItemsController < PrivateController
  def index
    @news_items = NewsItem.all
  end

  def show
    @news_item = NewsItem.find(params[:id])
  end

  def new
    @news_item = NewsItem.new
  end

  def create
    @news_item = NewsItem.new(params[:news_item])
    if @news_item.save
      flash[:notice] = "Successfully created news item."
      redirect_to news_items_path
    else
      render :action => 'new'
    end
  end

  def edit
    @news_item = NewsItem.find(params[:id])
  end

  def update
    @news_item = NewsItem.find(params[:id])
    if @news_item.update_attributes(params[:news_item])
      flash[:notice] = "Successfully updated news item."
      redirect_to news_items_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @news_item = NewsItem.find(params[:id])
    @news_item.destroy
    flash[:notice] = "Successfully destroyed news item."
    redirect_to news_items_url
  end
end

