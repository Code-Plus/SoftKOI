require 'test_helper'

class SaleDetailsControllerTest < ActionController::TestCase
  setup do
    @sale_detail = sale_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sale_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sale_detail" do
    assert_difference('SaleDetail.count') do
      post :create, sale_detail: { discount: @sale_detail.discount, price: @sale_detail.price, product_id: @sale_detail.product_id }
    end

    assert_redirected_to sale_detail_path(assigns(:sale_detail))
  end

  test "should show sale_detail" do
    get :show, id: @sale_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sale_detail
    assert_response :success
  end

  test "should update sale_detail" do
    patch :update, id: @sale_detail, sale_detail: { discount: @sale_detail.discount, price: @sale_detail.price, product_id: @sale_detail.product_id }
    assert_redirected_to sale_detail_path(assigns(:sale_detail))
  end

  test "should destroy sale_detail" do
    assert_difference('SaleDetail.count', -1) do
      delete :destroy, id: @sale_detail
    end

    assert_redirected_to sale_details_path
  end
end
