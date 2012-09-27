#coding:utf-8
require_dependency "ruser/application_controller"

module Ruser
  class AccountController < ApplicationController
  	    layout "rtheme/ruser"
    def new
    	@user = Ruser::User.new
    end

    def create
     @user = Ruser::User.new(params[:user])
     @user.activate=rand(Time.now.to_i+100000000000).to_s
     @user.status="new_register"

      respond_to do |format|

        if @user.save
          format.html {  render action: "show", notice: 'User was successfully created.' }
          format.json { render json: @user, status: :created, location: @user }
        #create a session
        session[:user_id]=@user.id  #BSon to string??,no
        session[:user_name]=@user.name
        session[:user_email]=@user.email
        else
          format.html { render action: "new"}
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  
    def edit
    end

    def show
    	@user =  current_user
    end
  end
end
