Rails.application.routes.draw do
  devise_for :user, controllers: { registrations: 'user/registrations' }

  root to: "group#index"

  resources :user do 
    resources :group
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html


  # Defines the root path route ("/")
  # root "articles#index"
end
