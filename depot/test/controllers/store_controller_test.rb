require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  include ActionView::Helpers::NumberHelper
  test "should get index" do
    get :index
    assert_response :success
    assert_select '.media', 3
    assert_select '.price', /\$[,\d]+\.\d\d/
    assert_select 'time', minimum: 1
    assert_select 'time', maximum: 1
  end

end
