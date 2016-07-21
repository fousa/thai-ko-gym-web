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
  end

  ### profile
  resource :profile, only: [:show, :edit, :update]

  # Set the root url
  root to: redirect('/users/sign_in')
end
