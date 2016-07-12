Rails.application.routes.draw do
  ### Setup Devise
  devise_for :users

  ### Home
  authenticated :user do
    # Make sure we don't get the authentication message when we didn't login.
    root 'home#index', as: :authenticated_root
  end

  ### users
  resources :users

  # Set the root url
  root to: redirect('/users/sign_in')
end
