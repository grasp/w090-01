Ruser::Engine.routes.draw do

  match "radmin/dashboard", :to => "radmin#dashboard"

  match "radmin/user_search", :to => "radmin#user_search"

  match "radmin/user_list", :to => "radmin#user_list"

  match "radmin/user_edit", :to => "radmin#user_edit"

  match "radmin/sconfig_list", :to => "radmin#sconfig_list"

  match "radmin/sconfig_edit", :to => "radmin#sconfig_edit"

  match "radmin/sconfig_udate", :to => "radmin#sconfig_udate"

  match "rsession/new", :to => "rsession#new"

  match "rsession/destroy", :to => "rsession#destroy"

  match "rpassword/new", :to => "rpassword#new"

  match "rpassword/edit", :to => "rpassword#edit"

  match "account/new", :to => "account#new"

  match "account/edit", :to => "account#edit"

  resources :users

end
