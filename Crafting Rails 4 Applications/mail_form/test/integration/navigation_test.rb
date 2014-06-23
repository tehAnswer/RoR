require "test_helper"

class NavigationTest < ActiveSupport::IntegrationCase
  setup do
    ActionMailer::Base.deliveries.clear
  end
  
  test 'sends an e-mail after filling the contact form' do
    visit '/'

    fill_in 'Name',    with: 'Nicki Minaj'
    fill_in 'Email',   with: 'nicki@minaj.com'
    fill_in 'Message', with: 'O!'

    click_button 'Deliver'
    assert_match 'Your message was successfully sent.', page.body

    assert_equal 1, ActionMailer::Base.deliveries.size
    mail = ActionMailer::Base.deliveries.last

    assert_equal ['nicki@minaj.com'], mail.from
    assert_equal ['recipient@example.com'], mail.to
    assert_match 'Message: O!', mail.body.encoded
  end
end