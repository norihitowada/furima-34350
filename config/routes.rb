Rails.application.routes.draw do
  devise_for :users

 root to:"items#index"

 resources :items do
  resources :purchase_records
 end
 

end
