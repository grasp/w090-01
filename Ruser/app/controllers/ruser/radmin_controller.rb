require_dependency "ruser/application_controller"

module Ruser
  class RadminController < ApplicationController
        layout "rtheme/ruser"
    before_filter :require_admin
    def dashboard
        @user_count = Ruser::User.count
        @users =Ruser::User.paginate(:page => params[:page], :per_page => 30)
    end
  
    def user_search
         @users =Ruser::User.where(:name => params[:q]).paginate(:per_page => 30)
         render "user_list"
    end
  
    def user_list
        @user_count = Ruser::User.count
        @users =Ruser::User.paginate(:page => params[:page], :per_page => 530)
    end
  
    def user_edit
    end
  
    def sconfig_list
    end
  
    def sconfig_edit
    end
  
    def sconfig_udate
    end
  end
end
