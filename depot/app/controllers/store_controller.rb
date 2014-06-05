class StoreController < ApplicationController
  include CurrentCart
  
  skip_before_action :authorize
  before_action :set_cart

  
  def index
  	counter
    @products = Product.order(:title)
  end

  private
  def counter
  	if session[:counter].nil?
  		session[:counter] = 1
  	else
  		session[:counter] += 1
  	end
  end
end

