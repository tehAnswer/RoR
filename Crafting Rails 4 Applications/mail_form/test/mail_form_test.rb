require 'test_helper'
require 'fixtures/sample_mail'

class MailFormTest < ActiveSupport::TestCase
  test 'sample mail has name and email' do
    sample = SampleMail.new

    sample.name = ''
    sample.email = ''
    assert !sample.name?
    assert !sample.email?

    sample.name = 'Nicki'
    sample.email = 'nicki@minaj.com'
    assert_equal sample.name, 'Nicki'
    assert_equal sample.email, 'nicki@minaj.com'
    assert sample.name?
    assert sample.email?


    sample.clear_name
    sample.clear_email
    assert_nil sample.name
    assert_nil sample.email
  end

  test 'deliver' do
    sample = SampleMail.new
    sample.email = 'nicki@minaj.com'
    sample.deliver

    assert_equal 1, ActionMailer::Base.deliveries.size
    mail = ActionMailer::Base.deliveries.last
    assert_equal ['nicki@minaj.com'], mail.from
    assert_match 'Email: nicki@minaj.com', mail.body.encoded
  end

  test 'honey pot spam' do
    sample = SampleMail.new nickname: 'Drake Drizzy'
    assert !sample.valid?
    assert_equal ["must be blank"], sample.errors[:nickname]
  end

  test 'provides hooks and callbacks' do
    sample = SampleMail.new email: 'nicki@minaj.com'
    sample.deliver
    assert_equal [:before, :after], sample.evaluated_callbacks
  end





 
end
