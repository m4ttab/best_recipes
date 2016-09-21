Rails.application.routes.draw do
  devise_for :users
 resources :recipes do
 	collection do 
 		get 'my'
 	end
 end

 root 'recipes#index'




end
