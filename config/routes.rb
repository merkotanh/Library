Rails.application.routes.draw do
  
  devise_for :users

  resources :books do
    resources :comments
  end

  resources :users do
    resources :comments
  end
  
  root 'books#index'
end
