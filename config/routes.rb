Rails.application.routes.draw do
  
  devise_for :users

  resources :books do
    resources :comments   
  end

  resources :users do
    resources :comments
  end

  resources :books do
    member do
      put 'take', to: "books#takebook"
      get 'take', to: "books#takebook"
    end
  end
  
  root 'books#index'
end
