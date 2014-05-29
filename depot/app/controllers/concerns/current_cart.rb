module CurrentCart
	extend ActiveSupport::Concern

	private

	def set_cart
		@cart = Cart.find(session[:cart_id])
		session[:counter] = 1
	rescue ActiveRecord::RecordNotFound
		#In the book, the author used Cart.create. This is a combo of .new and .save.
		@cart = Cart.create
		session[:cart_id] = @cart.id
	end
end