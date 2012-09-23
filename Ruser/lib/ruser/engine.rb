
require "mongoid"
require "pathname"
#project_path = Pathname.new(File.dirname(__FILE__)).parent
#require File.join(project_path ,"Ruser","config","initialize") #development use local path

module Ruser
  class Engine < ::Rails::Engine
    isolate_namespace Ruser
    
    #initializer 'Ruser::Application.helper,Ruser::User.helper,Ruser::ApplicationController' do |app|
       #ActionView::Base.send :include,Ruser::UsersHelper
     # ActionView::Base.send :include, Bootstrap::Breadcrumb::Helpers
        #ActionController::Base .send :include,  ApplicationHelper,UsersHelper
    #end
  end
end
