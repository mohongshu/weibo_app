require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  base_title = "爱吐槽"

  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "主页 | #{base_title}" 
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "帮助 | #{base_title}" 
  end

  test "should get about" do
  	get :about
  	assert_response :success
  	assert_select "title", "关于 | #{base_title}" 
  end
end
