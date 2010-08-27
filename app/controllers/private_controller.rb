class PrivateController < ApplicationController

  before_filter :retrieve_order, :retrieve_cart

  def show_index_page
  end

end

