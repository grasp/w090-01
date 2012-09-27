#coding:utf-8
class Ruser::User
  include Mongoid::Document
   @@per_page = 30
  field :email, type: String
  field :name, type: String
  field :admin, type: Boolean
  field :rname, type: String
  field :hpwd, type: String
  field :salt, type: String
  field :status, type: String
  field :activate, type: String
  field :preference, type: Integer
  field :mphone, type: String
  field :incnt, type: Integer
  field :curinat, type: Time
  field :lasinat, type: Time
  field :curinip, type: String
  field :lasinip, type: String
  field :bio, type: String
  field :webs, type: String

  validates_presence_of :email,:name,:message=>"用户名和email必须填写."
  validates_presence_of :mphone,:message=>"手机必须填写."
  validates_uniqueness_of :name ,:message=>"该用户名已经存在."
  validates_uniqueness_of :email ,:message=>"该email已经存在."
  validates_uniqueness_of :mphone ,:message=>"该手机已经存在."


  def self.authenticated_with_token(user_id, stored_salt)
    begin
     u = self.find(user_id)
     u && u.salt == stored_salt ? u : nil
     return u
    rescue
      Rails.logger.info("authentication failure!!")
       return nil
    end
   end
  
  def self.authenticate(email_or_name,password)
    if(email_or_name.match(/.*@.*\..*/))
    # user=self.first(:conditions => { :email=>email_or_name.to_s })  
     user = self.where(:email=>email_or_name.to_s).first   
    else
     # user=self.first(:conditions => { :name=>email_or_name.to_s })
     user = self.where(:name=>email_or_name.to_s).first
    end

    if user
      expected_password=encrypted_password(password,user.salt)
      if user.hpwd!=expected_password
        user= nil
        message="密码不对"
      end
    else
    message="#{email_or_name}用户不存在"
    user=nil
    end
    
    [user,message]
  end

  def password
    @password
  end  
  
  #here will generate password ,each result is different even have same password
  def password=(pwd)
    @password=pwd
    return if pwd.blank?
    create_new_salt
    self.hpwd=Ruser::User.encrypted_password(self.password, self.salt)
  end

 #private

  def password_non_blank
    errors.add_to_base("Missing password")  if :hashed_password.blank?
  end

 def self.encrypted_password(password,salt)
    string_to_hash=password+ "wibble" +salt
    Digest::SHA1.hexdigest(string_to_hash)
  end

  def create_new_salt
    self.salt= self.object_id.to_s+rand.to_s
  end

end
