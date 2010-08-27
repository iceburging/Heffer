class PublicController < ApplicationController

  before_filter :retrieve_order, :retrieve_cart

  def home
    @homepage = Page.find(:first,:conditions => {:title => 'homepage'})
    @news_items = NewsItem.find(:all,:limit => 3, :order => 'created_at DESC')
  end

  def show_page
    if params[:menu_entry].nil?
      @show_page = Page.find_by_permalink(params[:permalink])
    else
      @show_page = Page.find_by_permalink(params[:permalink], :joins => :menu_entry, :conditions => {'menu_entries.permalink' => params[:menu_entry]}) || Page.find(:first,:joins => :menu_entry, :conditions => {'menu_entries.permalink' => params[:menu_entry]}, :order => 'position ASC' )
    end
    if @show_page.nil?
      page = Page.new({ :menu_entry => MenuEntry.find_or_initialize_by_title(params[:menu_entry]), :title => 'Oops', :content => 'Sorry but the page you have requested can not be found.'})
      @show_page = page
    end
  end

protected

  def authorize
  end

end

