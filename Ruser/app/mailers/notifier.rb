#coding:utf-8
class Notifier < ActionMailer::Base
  default :from => "w090.master@w090.com"

  # send a signup email to the user, pass in the user object that contains the user's email address
  def send_signup_email(user)
    @user=user
    mail( 
      :from=>"w090.master@w090.com",
      :to => user.email, 
      :subject => "物流零距离-感谢您的注册，请点击以下链接确认你的邮箱",
      :template_path => 'users',
      :template_name => 'signup')
  end



  def send_pw_forget(user)
    @user=user
    mail( 
      :from=>"w090.master@w090.com",
      :to => user.email, 
      :subject => "来自物流零距离管理员，请点击以下链接重置您的密码")
  end


 end