require 'test_helper'

class ReservePricesControllerTest < ActionController::TestCase
  setup do
    @reserve_price = reserve_prices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reserve_prices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reserve_price" do
    assert_difference('ReservePrice.count') do
      post :create, reserve_price: { product_id: @reserve_price.product_id, time: @reserve_price.time, value: @reserve_price.value }
    end

    assert_redirected_to reserve_price_path(assigns(:reserve_price))
  end

  test "should show reserve_price" do
    get :show, id: @reserve_price
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reserve_price
    assert_response :success
  end

  test "should update reserve_price" do
    patch :update, id: @reserve_price, reserve_price: { product_id: @reserve_price.product_id, time: @reserve_price.time, value: @reserve_price.value }
    assert_redirected_to reserve_price_path(assigns(:reserve_price))
  end

  test "should destroy reserve_price" do
    assert_difference('ReservePrice.count', -1) do
      delete :destroy, id: @reserve_price
    end

    assert_redirected_to reserve_prices_path
  end
end
