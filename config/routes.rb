Rails.application.routes.draw do

  devise_for :users

  resources :histories
  resources :ratings

  resources :books do
    resources :comments
    resources :ratings
  end

  resources :users do
    resources :comments
    resources :ratings
  end

  resources :books do
    member do
      put :toggle_enable_status
    end
  end
  
  root 'books#index'

end
