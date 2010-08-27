class DataController < PublicController

  def sitemap
    @products = ProductLine.find_all_available
    @pages = Page.find(:all)
    headers['Content-Type'] = 'application/xml'
    render :layout => false
  end

  def products_feed
    @products = ProductLine.find_all_available
    headers['Content-Type'] = 'application/xml'
    render :layout => false
  end

end

