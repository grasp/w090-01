#coding:utf-8
require_dependency "ruser/application_controller"

module Ruser
  class RsessionController < ApplicationController
  	    layout "rtheme/ruser"
    def new
    end

  def authentication
    session[:user_id]= nil
    result=Ruser::User.authenticate( params[:email],params[:password])
    @user=result[0]
    if @user
        #user login succ, update last login time
        last_login=@user.lasinat
        if last_login
          if Time.now-last_login >86400 #if login after one day, generate new data for each user
          expire_fragment  "users_center_#{@user.id}"
          end
        end
        @user.update_attribute("lasinat",Time.now) unless @user.name=="admin"        
    end
    #authenticate with cookie
    
    if params[:remember_me]=="on" && @user
      @user.update_attributes(:preference=>1)
      #need store user_info into coockie
      cookies.permanent.signed[:remember_me] = [@user.id, @user.salt,1]   
      
    elsif params[:remember_me]=="off" && @user
       @user.update_attributes(:preference=>0)
       cookies.permanent.signed[:remember_me] = [@user.id, @user.salt,0]
    end

    respond_to do |format|
      # if @user.nil? || @user.status !="actived"
      if @user.nil?
         flash[:notice]="登录失败:#{result[1]}"
         format.html { redirect_to(:controller=>'rsession',:action=>"new")}
      else
       
        if @user.status =="new_register" 
          flash[:notice] = "登录成功，你还没有确认你的邮箱地址" 
        end
        record_user_session(@user) #record user information in session , so we can recoginzie
  
     #redirect to original URL
        unless session[:original_url]
          format.html { redirect_to ruser.account_show_path,:notice =>flash[:notice]}
        else
          format.html { redirect_to session[:original_url],:flash=>{:notice=>flash[:notice]}}
        end
      end
    end
    end
  
    def destroy
        destroy_user_session
        #delete cookie
        cookies.delete :remember_me
        redirect_to ruser.root_path,:notice =>"成功退出！"
    end
  end
end
