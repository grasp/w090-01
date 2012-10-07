#coding:utf-8
class Ruser::Notifier < ActionMailer::Base
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
      :subject => "来自物流零距离管理员，请点击以下链接重置您的密码",
      :body => generate_pw_forget_body(user)

  end

  def generate_pw_forget_body(user)
    body_string=String.new
  	body_string << "<div class='pw_forget'> \n"
    body_string << "<p>尊敬的用户 #{user.name},您好！</p> \n"
    body_string << "<p style="margin-left:20px;">您在<a href="w090.com">物流零距离</a>上注册了一个用户, 此封邮件为忘记密码重置邮件.</p>"
    body_string << "<p>点击下面的链接重置您的密码："
    
  #  body_string <<"<a href='http://w090.com/users/change_password_confirm/#{user.activate}'> http://w090.com/users/change_password_confirm/#{user.activate}</a>"
   body_string <<"<a href='http://localhost:3000/ruser/rpassword/change_password_confirm/#{user.activate}'> http://localhost:3000/ruser/rpassword/change_password_confirm/#{user.activate}</a>"
    
   body_string << "</p>"  
   body_string << " <p style='margin-left:30px;'> - 物流零距离管理员</p>"
   body_string << "</div>"
   return body_string
  end
 end