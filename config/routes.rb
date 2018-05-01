Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [] do
    member do
      resources :merchants
    end
  end

  authenticated :user do
    root to: 'merchants#index', as: :authenticated_root
  end

  root 'static#welcome'
end
