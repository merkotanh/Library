Rails.application.routes.draw do
  
  get 'histories/index'
  get 'histories/show'
  get 'history/index'
  get 'history/show'
  devise_for :users

  resources :histories

  resources :books do
    resources :comments   
  end

  resources :users do
    resources :comments
  end

resources :books do
    member do
        put :toggle_enable_status
    end
end
  
  root 'books#index'
end
