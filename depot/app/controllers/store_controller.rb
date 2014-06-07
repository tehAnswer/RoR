class StoreController < ApplicationController
  include CurrentCart
  
  skip_before_action :authorize
  before_action :set_cart

  
  def index
  	counter
    if params[:set_locale]
      redirect_to store_url(locale: params[:set_locale])
    else
      @products = Product.where(locale: I18n.locale).order(:title)
    end
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

