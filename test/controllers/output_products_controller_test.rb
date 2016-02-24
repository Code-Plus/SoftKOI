require 'test_helper'

class OutputProductsControllerTest < ActionController::TestCase
  setup do
    @output_product = output_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:output_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create output_product" do
    assert_difference('OutputProduct.count') do
      post :create, output_product: { product_id: @output_product.product_id, stock: @output_product.stock }
    end

    assert_redirected_to output_product_path(assigns(:output_product))
  end

  test "should show output_product" do
    get :show, id: @output_product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @output_product
    assert_response :success
  end

  test "should update output_product" do
    patch :update, id: @output_product, output_product: { product_id: @output_product.product_id, stock: @output_product.stock }
    assert_redirected_to output_product_path(assigns(:output_product))
  end

  test "should destroy output_product" do
    assert_difference('OutputProduct.count', -1) do
      delete :destroy, id: @output_product
    end

    assert_redirected_to output_products_path
  end
end
