Rails.application.routes.draw do
  devise_for :user, controllers: { registrations: 'user/registrations' }

  root to: "group#index"

  resources :user do 
    resources :group, only: [:index, :new, :create, :show] do
      resources :movement, only: [:index, :new, :create, :show]
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html


  # Defines the root path route ("/")
  # root "articles#index"
end