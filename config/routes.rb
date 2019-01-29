Rails.application.routes.draw do
  root "users#index"
  resources :microposts
  resources :users
end
