require 'test_helper'

class InputProductsControllerTest < ActionController::TestCase
  setup do
    @input_product = input_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:input_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create input_product" do
    assert_difference('InputProduct.count') do
      post :create, input_product: { product_id: @input_product.product_id, stock: @input_product.stock, stock_min: @input_product.stock_min }
    end

    assert_redirected_to input_product_path(assigns(:input_product))
  end

  test "should show input_product" do
    get :show, id: @input_product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @input_product
    assert_response :success
  end

  test "should update input_product" do
    patch :update, id: @input_product, input_product: { product_id: @input_product.product_id, stock: @input_product.stock, stock_min: @input_product.stock_min }
    assert_redirected_to input_product_path(assigns(:input_product))
  end

  test "should destroy input_product" do
    assert_difference('InputProduct.count', -1) do
      delete :destroy, id: @input_product
    end

    assert_redirected_to input_products_path
  end
end
