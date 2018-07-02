Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :users, only: [:show] do
      resources :merchants do
        resources :links, only: [:create, :edit, :update, :destroy]
      end
      get '/current_favorite', to: 'merchants#favorite'
  end


  authenticated :user do
    root to: 'users#show', as: :authenticated_root
  end

  root 'static#welcome'

  get '/about', to: 'static#about'



end
