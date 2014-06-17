require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products

  test "buying a product" do
    LineItem.delete_all
    Order.delete_all
   

    # Nicki goes to the store index...
    go_to_store_index
    # ... and then she add a product to her cart.
    add_a_product
    # Finally, she press the checkout buttom...
    press_checkout
    # ... and fill the details order form.
    filled_details_order_form
    # At this time, the order must be stored in the database.
    check_order_stored
    # Also, and email must be sent.
    check_email_sent
  end

  def go_to_store_index
  	get '/'
  	assert_response :success
  	assert_template 'index'
  end

  def add_a_product
  	cart = Cart.find(session[:cart_id])
  	assert_equal 0, cart.line_items.count
  	game_of_thrones = products(:one)

  	# Because the application uses AJAX.
  	xml_http_request :post, '/line_items', product_id: game_of_thrones.id
  	assert_response :success

  	assert_equal 1, cart.line_items.count
  	assert_equal game_of_thrones, cart.line_items[0].product
  end

  def press_checkout
  	get '/orders/new'
  	assert_response :success
  	assert_template 'new'
  end

  def filled_details_order_form
  	post_via_redirect '/orders', order: {
  		name: 'Nicki Minaj',
  		address: '123 Little Hill',
  		email: 'nicki@ymcmb.com',
  		pay_type: 'Check'
  	}
  	assert_response :success
  	assert_template 'index'
  	cart = Cart.find(session[:cart_id])
  	assert_equal 0, cart.line_items.count
  end

  def check_order_stored
  	order = Order.all.last
  	game_of_thrones = products(:one)
  	assert_equal 'Nicki Minaj', order.name
  	assert_equal 'Check', order.pay_type
  	assert_equal 1, order.line_items.count
  	assert_equal game_of_thrones, order.line_items[0].product
  end

  def check_email_sent
  	mail = ActionMailer::Base.deliveries.last
  	assert_equal ['nicki@ymcmb.com'], mail.to
  	assert_match /tehAnswer@me.com/, mail[:from].value
  	assert_equal 'Pragmatic Store: Order confirmation.', mail.subject
  end



end
