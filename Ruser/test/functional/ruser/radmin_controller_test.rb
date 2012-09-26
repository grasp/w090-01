require 'test_helper'

module Ruser
  class RadminControllerTest < ActionController::TestCase
    test "should get dashboard" do
      get :dashboard
      assert_response :success
    end
  
    test "should get user_search" do
      get :user_search
      assert_response :success
    end
  
    test "should get user_list" do
      get :user_list
      assert_response :success
    end
  
    test "should get user_edit" do
      get :user_edit
      assert_response :success
    end
  
    test "should get sconfig_list" do
      get :sconfig_list
      assert_response :success
    end
  
    test "should get sconfig_edit" do
      get :sconfig_edit
      assert_response :success
    end
  
    test "should get sconfig_udate" do
      get :sconfig_udate
      assert_response :success
    end
  
  end
end
