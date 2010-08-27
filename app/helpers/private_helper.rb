module PrivateHelper

  def insert_private_sub_menu
    begin
      render :partial => "private/#{current_menu}_menu"
    rescue ActionView::MissingTemplate => e
      render :text => ""
    end
  end

  def current_menu
    request.env['PATH_INFO'].split('/')[2] || ''
  end

end

