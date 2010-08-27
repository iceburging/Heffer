# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def insert_bottom_bar
    permalinks = ['legal','privacy','contact']
    bottom_bar = permalinks.map do |permalink|
      page = Page.find_by_permalink(permalink)
      unless page.nil?
        if page.menu_entry.nil?
          concat(link_to(page.title.capitalize, site_path(permalink)) + ' ')
        else
          concat(link_to(page.title.capitalize, static_path(page.menu_entry.permalink,permalink)) + ' ')
        end
      end
    end
    bottom_bar.compact.to_s
  end

  def insert_address(address)
    capture_haml do
      haml_tag :div, {:class => 'address'} do
        haml_tag :ul, {:style => 'list-style-type: none;'} do
          address.each do |line|
            haml_tag :li, line
          end
        end
      end
    end
  end

  def get_secure_protocol
    if RAILS_ENV == 'production'
      return 'https'
    else
      return 'http'
    end
  end

 def insert_site_image(tag,options = {})
   image = Image.find_by_tag(tag)
   if image.nil?
     options[:alt] = 'sorry cannot find image' if options[:alt].nil?
     image_tag('', options)
   else
     options[:alt] = image.try(:title) if options[:alt].nil?
     image_tag(standard_image_path(image.try(:id),:format => :png),options)
   end
 end
end

