require 'test_helper'

class TypesConsolesControllerTest < ActionController::TestCase
  setup do
    @types_console = types_consoles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:types_consoles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create types_console" do
    assert_difference('TypesConsole.count') do
      post :create, types_console: { name: @types_console.name }
    end

    assert_redirected_to types_console_path(assigns(:types_console))
  end

  test "should show types_console" do
    get :show, id: @types_console
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @types_console
    assert_response :success
  end

  test "should update types_console" do
    patch :update, id: @types_console, types_console: { name: @types_console.name }
    assert_redirected_to types_console_path(assigns(:types_console))
  end

  test "should destroy types_console" do
    assert_difference('TypesConsole.count', -1) do
      delete :destroy, id: @types_console
    end

    assert_redirected_to types_consoles_path
  end
end
