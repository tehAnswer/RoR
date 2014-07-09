require 'test_helper'

class ProdudctsControllerTest < ActionController::TestCase
  setup do
    @produdct = produdcts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:produdcts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create produdct" do
    assert_difference('Produdct.count') do
      post :create, produdct: { name: @produdct.name }
    end

    assert_redirected_to produdct_path(assigns(:produdct))
  end

  test "should show produdct" do
    get :show, id: @produdct
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @produdct
    assert_response :success
  end

  test "should update produdct" do
    patch :update, id: @produdct, produdct: { name: @produdct.name }
    assert_redirected_to produdct_path(assigns(:produdct))
  end

  test "should destroy produdct" do
    assert_difference('Produdct.count', -1) do
      delete :destroy, id: @produdct
    end

    assert_redirected_to produdcts_path
  end
end
