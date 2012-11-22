require 'test_helper'

class IdeaPostingsControllerTest < ActionController::TestCase
  setup do
    @idea_posting = idea_postings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:idea_postings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create idea_posting" do
    assert_difference('IdeaPosting.count') do
      post :create, idea_posting: {  }
    end

    assert_redirected_to idea_posting_path(assigns(:idea_posting))
  end

  test "should show idea_posting" do
    get :show, id: @idea_posting
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @idea_posting
    assert_response :success
  end

  test "should update idea_posting" do
    put :update, id: @idea_posting, idea_posting: {  }
    assert_redirected_to idea_posting_path(assigns(:idea_posting))
  end

  test "should destroy idea_posting" do
    assert_difference('IdeaPosting.count', -1) do
      delete :destroy, id: @idea_posting
    end

    assert_redirected_to idea_postings_path
  end
end
