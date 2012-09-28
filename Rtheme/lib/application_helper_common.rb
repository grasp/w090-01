#coding:utf-8
module ApplicationHelperCommon
  def current_user_login?
    return  true unless session[:user_id].blank? #avoid read again and again
    #add cookie login
    unless cookies.signed.blank?
     exist_cookie= cookies.signed[:remember_me]
     unless exist_cookie.blank?
      if  exist_cookie[2] == 1
       current_user = Ruser::User.authenticated_with_token(exist_cookie[0],exist_cookie[1])
       if current_user
         record_user_session(current_user)
       return true
       end   
      end
     end 
    end
   current_user.nil? ? false : true
  end

def record_user_session(current_user)
    session[:user_id]=current_user.id  #BSon to string??,no
    session[:user_name]=current_user.name
    session[:user_email]=current_user.email
    session[:admin] = true if current_user.name=="admin"
end

def destroy_user_session
    session[:user_id]= nil
    session[:user_name]= nil
    session[:user_email]=nil
    session[:admin] = false
end

#add to before filter
def require_user
  redirect_to ruser.rsession_new_path,:notice=>"请先登录" if session[:user_id].nil?
end

def require_admin
  redirect_to ruser.rsession_new_path,:notice=>"sorry, you dont have permission for this" unless session[:admin]
end
  
  def notice_message
    flash_messages = []

    flash.each do |type, message|
      type = :success if type == :notice
      text = content_tag(:div, link_to("x", "#", :class => "close",:"data-dismiss"=>"alert") + message, :class => "alert alert-#{type} fade in")
      flash_messages << text if message
    end

    flash_messages.join("\n").html_safe
  end

  def admin?(user = nil)
    user ||= current_user
    user.try(:admin?)
  end
#should be move out
  def wiki_editor?(user = nil)
    user ||= current_user
    user.try(:wiki_editor?)
  end

  def owner?(item)
    return false if item.blank? or current_user.blank?
    item.user_id == current_user.id
  end

  def timeago(time, options = {})
    options[:class] ||= "timeago"
    content_tag(:abbr, time.to_s, options.merge(:title => time.getutc.iso8601)) if time
  end

  def render_page_title
    #Here is a bug, as we debug Ruser, so use Ruser as first
    title = @page_title ? "#{@page_title} | #{Ruser::Setting.app_name}" : Ruser::Setting.app_name rescue "#{Ruser::Setting.app_name}"
    content_tag("title", title, nil, false)
  end

  # 去除区域里面的内容的换行标记
  def spaceless(&block)
    data = with_output_buffer(&block)
    data = data.gsub(/\n\s+/,"")
    data = data.gsub(/>\s+</,"><")
    raw data
  end

  def facebook_enable
    Ruser::Setting.facebook_enable
  end
  
MOBILE_USER_AGENTS =  'palm|blackberry|nokia|phone|midp|mobi|symbian|chtml|ericsson|minimo|' +
                        'audiovox|motorola|samsung|telit|upg1|windows ce|ucweb|astel|plucker|' +
                        'x320|x240|j2me|sgh|portable|sprint|docomo|kddi|softbank|android|mmp|' +
                        'pdxgw|netfront|xiino|vodafone|portalmmm|sagem|mot-|sie-|ipod|up\\.b|' +
                        'webos|amoi|novarra|cdm|alcatel|pocket|iphone|mobileexplorer|mobile'

  def mobile?
    agent_str = request.user_agent.to_s.downcase
    return false if agent_str =~ /ipad/
    agent_str =~ Regexp.new(MOBILE_USER_AGENTS)
  end
end