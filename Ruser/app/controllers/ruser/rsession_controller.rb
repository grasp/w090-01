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
         format.html { redirect_to(:controller=>'users',:action=>"login")}
      else
       
        if @user.status =="new_register" 
          flash[:notice] = "请到你的邮箱#{@user.email}去确认邮箱" 
        end

        #keep session information for next use
        session[:user_id]=@user.id  #BSon to string??,no
        session[:user_name]=@user.name
        session[:user_email]=@user.email
  
     #redirect to original URL
        unless session[:original_url]
        format.html { redirect_to "/",:flash=>{:notice=>flash[:notice]}}
        else
        format.html { redirect_to session[:original_url],:flash=>{:notice=>flash[:notice]}}
        end

      end
    end
    end
  
    def destroy
    end
  end
end
