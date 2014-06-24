require "test_helper"

class RenderingTest < ActionDispatch::IntegrationTest
  test '.rb template handler' do
    expected = 'This is my first <b>template handler</b>!'
    check_handler '/handlers/rb_handler', expected
  end

  test '.string template handler' do
  	expected = 'Congratulations! You just created another template handler!'
  	check_handler '/handlers/string_handler', expected
  end

  test '.md template handler' do
  	expected = '<p>RDiscount is <em>cool</em> and <strong>fast</strong>!</p>'
  	check_handler '/handlers/rdiscount', expected
  end

  test ".merb template handler" do
    expected = "<p>MERB template handler is <strong>cool and fast</strong>!</p>" 
    check_handler '/handlers/merb', expected
  end

  test "dual template with .merb" do
    email = Notifier.contact("you@example.com")
    assert_equal 2, email.parts.size
    assert_equal "multipart/alternative", email.mime_type

    assert_equal "text/plain", email.parts[0].mime_type
    assert_equal "Dual templates **rock**!",
      email.parts[0].body.encoded.strip

    assert_equal "text/html", email.parts[1].mime_type
    assert_equal "<p>Dual templates <strong>rock</strong>!</p>",
      email.parts[1].body.encoded.strip
  end

  def check_handler (route, expected)
  	get route
  	assert_match expected, response.body
  end

  private :check_handler

end