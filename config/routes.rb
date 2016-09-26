Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "acme/omniauth_callbacks", registrations: "acme/registrations" }
 resources :recipes do
 	collection do 
 		get 'my'
 	end
 end

 root 'recipes#index'




end
