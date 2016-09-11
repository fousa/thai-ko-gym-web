Rails.application.routes.draw do
  ### Setup Devise
  as :user do
    patch '/users/confirmation' => 'confirmations#update', as: :update_user_confirmation, via: :patch
  end
  devise_for :users, controllers: { confirmations: 'confirmations' }

  ### Home
  authenticated :user do
    # Make sure we don't get the authentication message when we didn't login.
    root 'home#index', as: :authenticated_root
  end

  ### users
  resources :users do
    member do
      post :invite
    end
    collection do
      get :active
      get :inactive
    end
  end

  ### Presences
  resources :presences, only: [:index, :show]

  ### profile
  resource :profile, only: [:show, :edit, :update] do
    collection do
      patch :update_password
    end
  end

  ### API
  namespace :api do
    post 'authenticate', to: 'authentication#create'

    resources :users, only: [:index, :active] do
      collection do
        get :active
      end
    end
    resources :presences, only: [:create]
  end

  ### error
  %w(404 403 422 500 503).each do |code|
    get code, to: 'errors#show', code: code, as: "error_#{code}"
  end

  # Set the root url
  root to: redirect('/users/sign_in')
end
