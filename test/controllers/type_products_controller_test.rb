require 'test_helper'

class TypeProductsControllerTest < ActionController::TestCase
  setup do
    @type_product = type_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:type_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create type_product" do
    assert_difference('TypeProduct.count') do
      post :create, type_product: { description: @type_product.description, name: @type_product.name, state: @type_product.state }
    end

    assert_redirected_to type_product_path(assigns(:type_product))
  end

  test "should show type_product" do
    get :show, id: @type_product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @type_product
    assert_response :success
  end

  test "should update type_product" do
    patch :update, id: @type_product, type_product: { description: @type_product.description, name: @type_product.name, state: @type_product.state }
    assert_redirected_to type_product_path(assigns(:type_product))
  end

  test "should destroy type_product" do
    assert_difference('TypeProduct.count', -1) do
      delete :destroy, id: @type_product
    end

    assert_redirected_to type_products_path
  end
end
