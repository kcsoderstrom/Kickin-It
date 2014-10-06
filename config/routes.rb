Rails.application.routes.draw do
  resources :users do
    resources :comments, only: [:index]
  end

  resource :session, only: [:create, :new, :destroy]

  resources :goals do
    resources :comments, only: [:index]
  end

  root to: 'users#new'
  resources :comments, only: [:create, :destroy]
end
