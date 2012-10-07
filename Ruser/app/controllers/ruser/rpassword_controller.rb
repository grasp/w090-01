#coding:utf-8
require_dependency "ruser/application_controller"

module Ruser
  class RpasswordController < ApplicationController
  	    layout "rtheme/ruser"

    def new
    end
  
    def edit
    end

    def pw_reset_request

    end

   def pwreset
   # @user=User.first(:conditions=>{:name=>params[:username]}) 
    @user=Ruser::User.where(:name=>params[:username]).first
    #get the user from the hash
    if  params[:password] ==  params[:password_confirmation]
      #update the password here
    @user.password=params[:password]
    flash[:notice] = "密码修改成功，请登录"   if  @user.save(validate: false)
   else
	  flash[:notice] = "两次输入的密码不一致，请重新输入 "
    end
   

    respond_to do |format|
      #redirect to login if not actived,even authenticate is pass
      format.html { redirect_to(:controller=>"rsession",:action=>"new",:notice => flash[:notice]) }
    end
   end


  def pw_sent_confirm
  
  @user=Ruser::User.where(:email=>params[:email]).first
  
   unless @user.blank?
        @user.update_attribute(:activate,rand(Time.now.to_i+10000000000).to_s)
       # @user.update_attribute(:status,"forgot-password")
    begin

    Notifier.send_pw_forget(@user).deliver!

      flash[:notice] = "密码重置邮件已经发出,请到您的邮箱接收，并点击链接重置密码 "
    rescue
     flash[:notice] = "密码重置邮件发送失败，我们会马上解决 "     
        #warn the admin here
    end
   
  else
    @error="邮箱不存在"
  end      
      respond_to do |format|
        #redirect to login if not actived,even authenticate is pass
        format.html { redirect_to :controller=>"rsession",:action=>"new",:flash=>{:notice=>flash[:notice]}}
      end
  end

  def  change_password_confirm
     @user=Ruser::User.where(:activate=>params[:activate].to_s).first
    # need check the code of activate field from the
     respond_to do |format|
      if  @user.activate == params[:activate]
        format.html # index.html.erb
        format.xml
      else
        flash[:notice] = "密码重置链接无效,重置密码失败"
        format.html { redirect_to :controller=>"rsession",:action =>"new" ,:flash=>{:notice=>flash[:notice]}}
        format.xml  { head :ok }
      end
    end
  end
    
  end
end
