WdiProspectsBrowser::Application.routes.draw do

  resources :wdi_refined_prospects


  resources :change_histories


  resources :users
  resources :wdi_prospects
  resources :sessions
  resources :password_resets

  get "log_in" => "sessions#new", :as => "log_in"
  
  get "log_out" => "sessions#destroy", :as => "log_out"

  get "sign_up" => "users#new", :as => "sign_up"

  get "search" => "wdi_prospects#search", :as => "search"
  #Search WDI Refined Propspects
  get "search_refined_prospects" => "wdi_refined_prospects#searchRefinedProspects", :as => "search_refined_prospects"

  #Import records to Prospects table
  get "uploadfile" => "wdi_prospects#uploadfile", :as => "uploadfile"
  post "import" => "wdi_prospects#import", :as => "import"
  
  #Import records to Refined-Prospects table
  #get "upload_refined_file" => "wdi_refined_prospects#uploadRefinedFile", :as => "upload_refined_file"
  post "import_to_refined" => "wdi_refined_prospects#importToRefined", :as => "import_to_refined"
  
  # Del Prospects
  post "delProspects" => "wdi_prospects#delProspects", :as => "delProspects"
  # Del Refined Prospects
  post "del_refined_prospects" => "wdi_refined_prospects#delRefinedProspects", :as => "del_refined_prospects"
  

  get "home/index"
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'sessions#new'
  
end
