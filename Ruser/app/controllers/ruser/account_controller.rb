#coding:utf-8
require_dependency "ruser/application_controller"

module Ruser
  class AccountController < ApplicationController
  	    layout "rtheme/ruser"
        before_filter :require_user,:only=>[:edit,:show]
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
          record_user_session(@user) #record user information in session , so we can recoginzie
        else
          format.html { render action: "new"}
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  
    def edit
       @user =  Ruser::User.find(session[:user_id]) if session[:user_id]
    end

    def show
    	@user =  Ruser::User.find(session[:user_id]) if session[:user_id]
    end

    def update
       @user =  Ruser::User.find(session[:user_id]) if session[:user_id]
       if @user.id == params[:user_id] && @user.name!= "admin"
        redirect_to action:"show",:notice=>"只能编辑自己的账户"
       end
     if  @user.update_attributes(params[:user])
        redirect_to action:"show",:notice=>"更新成功"
     else
       redirect_to action:"edit",:notice=>"更新失败了"
     end
    end
  end
end
