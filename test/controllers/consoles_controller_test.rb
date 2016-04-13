require 'test_helper'

class ConsolesControllerTest < ActionController::TestCase
  setup do
    @console = consoles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:consoles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create console" do
    assert_difference('Console.count') do
      post :create, console: { description: @console.description, name: @console.name, serial: @console.serial, state: @console.state }
    end

    assert_redirected_to console_path(assigns(:console))
  end

  test "should show console" do
    get :show, id: @console
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @console
    assert_response :success
  end

  test "should update console" do
    patch :update, id: @console, console: { description: @console.description, name: @console.name, serial: @console.serial, state: @console.state }
    assert_redirected_to console_path(assigns(:console))
  end

  test "should destroy console" do
    assert_difference('Console.count', -1) do
      delete :destroy, id: @console
    end

    assert_redirected_to consoles_path
  end
end
