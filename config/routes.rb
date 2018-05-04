Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :users, only: [], param: :user_id do
    member do
      resources :merchants
      get '/last_visit', to: 'merchants#last_visit'
    end
  end

  authenticated :user do
    root to: 'merchants#index', as: :authenticated_root
  end

  root 'static#welcome'

end
