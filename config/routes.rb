ActionController::Routing::Routes.draw do |map|

  map.products_feed 'products_feed.xml', :controller => "data", :action => "products_feed"

  map.sitemap 'sitemap.xml', :controller => "data", :action => "sitemap"

  map.resources :users, :path_prefix => "private/users"

  map.resources :shipping_methods, :path_prefix => "private/shipping"

  map.resources :countries, :path_prefix => "private/shipping"

  map.resources :options, :path_prefix => "private/merchandise"

  map.resources :product_lines, :path_prefix => "private/merchandise"

  map.resources :manufacturers, :path_prefix => "private/merchandise"

  map.resources :flags, :path_prefix => "private/merchandise"

  map.resources :categories, :path_prefix => "private/merchandise"

  map.resources :photos, :path_prefix => "private/merchandise", :member => { :thumb => :get, :polaroid => :get, :standard => :get  }

  map.resources :images, :path_prefix => "private/site_content", :member => { :thumb => :get, :standard => :get  }

  map.resources :menu_entries, :path_prefix => "private/site_content"

  map.resources :pages, :path_prefix => "private/site_content"

  map.resources :news_items, :path_prefix => "private/site_content"

  map.resources :orders, :path_prefix => "private", :only => [:new, :create, :show, :destroy], :collection => {:active => :get, :completed => :get, :inactive => :get, :update_order => :post, :empty_cart => :put, :remove_from_cart => :put}, :member => [:capture, :void, :refund, :dispatch]

  map.login "private/access/:action", :controller => "login", :action => "login"

  map.connect "private/:menu_entry", :controller => "private", :action => "show_index_page", :menu_entry => 'welcome'

  map.product_details "products/details/:id", :controller => "products", :action => "details"

  map.connect "products/add_to_cart", :controller => "products", :action => "add_to_cart"

  map.products "products/:category/:filter", :controller => "products", :action => "list", :category => "all", :filter => "all"

  map.checkout "checkout/:action", :controller => "checkout", :action => "index"

  map.help "help/:action", :controller => "help"

  map.site "site/:permalink", :controller => "public", :action => "show_page"

  map.static ":menu_entry/:permalink", :controller => "public", :action => "show_page", :permalink => "index"

  map.root :controller => "public", :action => "home"

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  # map.connect 'private/:controller/:action/:id', :controller => "private"
  # map.connect 'private/:controller/:action/:id.:format', :controller => "private"
end

