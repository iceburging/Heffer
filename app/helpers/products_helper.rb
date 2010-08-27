module ProductsHelper

  def insert_products_sub_menu
    categories = ProductLine.find(:all,:select => 'DISTINCT category_id').map{|p| p.category.permalink if p.category}.compact
    categories.each do |category|
      if params[:category] == category
        concat(content_tag :li, link_to(category.titleize , {:controller => 'products', :action => 'list', :category => category }), {:id => 'selected_sub_menu'})
      else
        concat(content_tag :li, link_to(category.titleize , {:controller => 'products', :action => 'list', :category => category }))
      end
    end
  end

  def insert_products_filter_menu
    if params[:category] == 'all'
      flags = Flag.find(:all,:conditions => 'id in (select distinct flag_id from flags_product_lines)').map{|f| f.permalink if f.permalink}.compact
    else
      flags = ProductLine.find(:all, :select => 'DISTINCT flags.permalink',:joins => [:category, :flags], :conditions => ['categories.permalink = ?', params[:category]]).map{|p| p.permalink if p.permalink}.compact
    end
    flags.each do |flag|
      if params[:filter] == flag
        concat(content_tag :li, link_to(flag.titleize , {:controller => 'products', :action => 'list', :category => params[:category], :filter => flag }), {:class => 'selected_filter_menu'})
      else
        concat(content_tag :li, link_to(flag.titleize , {:controller => 'products', :action => 'list', :category => params[:category], :filter => flag }))
      end
    end
  end

  def insert_product_thumbnail(product)
    photo = product.photos[0] || Photo.find_by_title('default')
    unless photo.nil?
      link_to(image_tag(thumb_photo_path(photo, :format => :jpg)), {:controller => 'products', :action => 'details', :id => product.id})
    end
  end

  def product_thumbnail_full_path(product)
    photo = product.photos[0] || Photo.find_by_title('default')
    unless photo.nil?
      thumb_photo_path(photo, :format => :jpg, :only_path => false)
    end
  end

  def insert_product_polaroids(product,image_number)
    image_number ||= 1
    image_number = image_number.to_i
    photos = product.photos || Photo.find_by_title('default')
    photos.each_with_index do |photo,index|
      if index + 1  == image_number
        concat(image_tag(polaroid_photo_path(photo, :format => :jpg), {:class => 'main_image', :alt => "#{index+1}"}))
      else
        concat(image_tag(polaroid_photo_path(photo, :format => :jpg), {:class => 'main_image', :alt => "#{index+1}", :style => 'display: none;'}))
      end
    end
  end

  def insert_image_navigation(product,image_number)
    image_number ||= 1
    image_number = image_number.to_i
    photos = product.photos || Photo.find_by_title('default')
    if photos.length > 1
      concat(link_to(image_tag('/images/site/backward.png',{:class => 'backward'}),{:image => photos.length-(photos.length-image_number+1).remainder(photos.length)},{:id => 'backward_link'}))
      concat(content_tag :p, "#{image_number}/#{photos.length}", {:id => 'image_number'})
      concat(link_to(image_tag('/images/site/forward.png',{:class => 'forward'}),{:image => image_number.abs.remainder(photos.length)+1},{:id => 'forward_link'}))
    end
  end

  def number_in_cart
    @cart.items.inject(0){|result,item| result + (item.option.product_line_id == @product.id ? item.quantity.to_i : 0)}
  end

  def set_products_title
    if params[:category].blank?
      title 'Products'
    else
      title 'Products' + ' - ' + params[:category].titleize
    end
  end

end

