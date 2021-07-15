Rails.application.routes.draw do
  devise_for :users

 root to:"items#index"

 resources :items do
  resources :purchase_records, only: [:index, :create]
  collection do
      get 'search'
    end
 end
 

end
