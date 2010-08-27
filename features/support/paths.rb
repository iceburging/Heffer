module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'
    when /the products page/
      products_path
    when /the add product line page/
      new_product_line_path
    when /the show cart page/
      '/checkout/show_cart'
    when /the login page/
      login_path
    when /the private index page/
      '/private'
    when /the active orders page/
      active_orders_path
    when /the completed orders page/
      completed_orders_path
    when /the inactive orders page/
      inactive_orders_path
    when /the create page page/
      new_page_path
    when /the sitemap page/
      sitemap_path
    when /the products feed page/
      products_feed_path

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)

