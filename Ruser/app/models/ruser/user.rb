class Ruser::User
  include Mongoid::Document
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
end
