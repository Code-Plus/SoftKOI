require 'test_helper'

class ItemCouponsControllerTest < ActionController::TestCase
  setup do
    @item_coupon = item_coupons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:item_coupons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create item_coupon" do
    assert_difference('ItemCoupon.count') do
      post :create, item_coupon: { coupon_id: @item_coupon.coupon_id, sale_id: @item_coupon.sale_id }
    end

    assert_redirected_to item_coupon_path(assigns(:item_coupon))
  end

  test "should show item_coupon" do
    get :show, id: @item_coupon
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @item_coupon
    assert_response :success
  end

  test "should update item_coupon" do
    patch :update, id: @item_coupon, item_coupon: { coupon_id: @item_coupon.coupon_id, sale_id: @item_coupon.sale_id }
    assert_redirected_to item_coupon_path(assigns(:item_coupon))
  end

  test "should destroy item_coupon" do
    assert_difference('ItemCoupon.count', -1) do
      delete :destroy, id: @item_coupon
    end

    assert_redirected_to item_coupons_path
  end
end
