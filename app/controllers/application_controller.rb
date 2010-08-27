# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.


class ApplicationController < ActionController::Base

  include ExceptionNotification::Notifiable

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :card_number, :card_verification_value

  # by default pages require login
  before_filter :authorize, :except => :login

protected

  def authorize
    unless User.find_by_id(session[:user_id]) || User.count.zero?
      flash[:notice] = "Please log in"
      redirect_to :controller => :login, :action => :login
    end
  end

	def render_optional_error_file(status_code)
    status = interpret_status(status_code)
    render :template => "/errors/#{status[0,3]}.html.haml", :status => status, :layout => 'public.html.erb'
  end

  def local_request?
    # must have config.action_controller.perform_caching = false set in environment
    false
  end

private

  def retrieve_order
    @order = find_order
  end

  def retrieve_cart
    @cart = @order.cart
  end

  def find_order
    session[:order] ||= Order.new(:cart => Cart.new, :ip_address => request.remote_ip, :active => true)
  end

end

