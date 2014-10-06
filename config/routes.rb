Rails.application.routes.draw do
  resources :users

  resource :session

  resources :goals

  root to: 'users#new'
end
