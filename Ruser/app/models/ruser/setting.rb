class Ruser::Setting < Settingslogic
  source "#{Ruser::Engine.root}/config/ruser.yml"
  namespace Rails.env
end