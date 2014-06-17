require 'test_helper'
require 'fixtures/sample_mail'

class MailFormTest < ActiveSupport::TestCase
  test "sample mail has name and email" do
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


  
end
