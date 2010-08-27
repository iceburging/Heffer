module PublicHelper

  def insert_menu
    menu_entries = MenuEntry.find(:all,:order => :position)
    if !menu_entries.nil?
      render :partial => 'public/menu', :collection => menu_entries
    end
  end

  def insert_public_sub_menu
    menu_entry = MenuEntry.find_by_permalink(params[:menu_entry])
    if !menu_entry.nil?
      pages = menu_entry.pages
      if !pages.nil?
        render :partial => 'public/sub_menu', :collection => pages.sort_by(&:position)
      end
    end
  end

end

