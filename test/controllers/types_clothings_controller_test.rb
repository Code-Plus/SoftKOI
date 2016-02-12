require 'test_helper'

class TypesClothingsControllerTest < ActionController::TestCase
  setup do
    @types_clothing = types_clothings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:types_clothings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create types_clothing" do
    assert_difference('TypesClothing.count') do
      post :create, types_clothing: { name: @types_clothing.name }
    end

    assert_redirected_to types_clothing_path(assigns(:types_clothing))
  end

  test "should show types_clothing" do
    get :show, id: @types_clothing
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @types_clothing
    assert_response :success
  end

  test "should update types_clothing" do
    patch :update, id: @types_clothing, types_clothing: { name: @types_clothing.name }
    assert_redirected_to types_clothing_path(assigns(:types_clothing))
  end

  test "should destroy types_clothing" do
    assert_difference('TypesClothing.count', -1) do
      delete :destroy, id: @types_clothing
    end

    assert_redirected_to types_clothings_path
  end
end
