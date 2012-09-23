require 'test_helper'

module Ruser
  class UsersControllerTest < ActionController::TestCase
    setup do
      @user = users(:one)
    end
  
    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:users)
    end
  
    test "should get new" do
      get :new
      assert_response :success
    end
  
    test "should create user" do
      assert_difference('User.count') do
        post :create, user: { activate: @user.activate, admin: @user.admin, bio: @user.bio, curinat: @user.curinat, curinip: @user.curinip, email: @user.email, hpwd: @user.hpwd, incnt: @user.incnt, lasinat: @user.lasinat, lasinip: @user.lasinip, mphone: @user.mphone, name: @user.name, preference: @user.preference, rname: @user.rname, salt: @user.salt, status: @user.status, webs: @user.webs }
      end
  
      assert_redirected_to user_path(assigns(:user))
    end
  
    test "should show user" do
      get :show, id: @user
      assert_response :success
    end
  
    test "should get edit" do
      get :edit, id: @user
      assert_response :success
    end
  
    test "should update user" do
      put :update, id: @user, user: { activate: @user.activate, admin: @user.admin, bio: @user.bio, curinat: @user.curinat, curinip: @user.curinip, email: @user.email, hpwd: @user.hpwd, incnt: @user.incnt, lasinat: @user.lasinat, lasinip: @user.lasinip, mphone: @user.mphone, name: @user.name, preference: @user.preference, rname: @user.rname, salt: @user.salt, status: @user.status, webs: @user.webs }
      assert_redirected_to user_path(assigns(:user))
    end
  
    test "should destroy user" do
      assert_difference('User.count', -1) do
        delete :destroy, id: @user
      end
  
      assert_redirected_to users_path
    end
  end
end
