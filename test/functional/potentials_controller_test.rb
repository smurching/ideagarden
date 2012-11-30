require 'test_helper'

class PotentialsControllerTest < ActionController::TestCase
  setup do
    @potential = potentials(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:potentials)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create potential" do
    assert_difference('Potential.count') do
      post :create, potential: {  }
    end

    assert_redirected_to potential_path(assigns(:potential))
  end

  test "should show potential" do
    get :show, id: @potential
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @potential
    assert_response :success
  end

  test "should update potential" do
    put :update, id: @potential, potential: {  }
    assert_redirected_to potential_path(assigns(:potential))
  end

  test "should destroy potential" do
    assert_difference('Potential.count', -1) do
      delete :destroy, id: @potential
    end

    assert_redirected_to potentials_path
  end
end
