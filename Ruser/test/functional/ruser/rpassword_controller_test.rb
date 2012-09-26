require 'test_helper'

module Ruser
  class RpasswordControllerTest < ActionController::TestCase
    test "should get new" do
      get :new
      assert_response :success
    end
  
    test "should get edit" do
      get :edit
      assert_response :success
    end
  
  end
end
