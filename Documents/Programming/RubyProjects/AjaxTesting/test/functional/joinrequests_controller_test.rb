require 'test_helper'

class JoinrequestsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get approve" do
    get :approve
    assert_response :success
  end

  test "should get reject" do
    get :reject
    assert_response :success
  end

end
