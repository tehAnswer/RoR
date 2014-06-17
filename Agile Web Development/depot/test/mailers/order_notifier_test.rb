require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "received" do
    order = orders(:one)
    order.add_line_items_from_cart(carts(:one))

    mail = OrderNotifier.received(order)
    assert_equal "Pragmatic Store: Order confirmation.", mail.subject
    assert_equal ["dave@gunit.com"], mail.to
    assert_equal ["tehAnswer@me.com"], mail.from
    assert_match /1 x Game of Thrones/, mail.body.encoded
  end

  test "shipped" do
    order = orders(:one)
    order.add_line_items_from_cart(carts(:one))
    mail = OrderNotifier.shipped(order)

    assert_equal "Pragmatic Store: Order shipped.", mail.subject
    assert_equal ["dave@gunit.com"], mail.to
    assert_equal ["tehAnswer@me.com"], mail.from
    assert_match /<td>Game of Thrones<\/td>/, mail.body.encoded
    assert_no_match /Destroy/, mail.body.encoded
  end

end
