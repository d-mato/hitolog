Rails.application.routes.draw do
  root 'home#index'
  get 'sign_in' => 'home#sign_in'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  namespace :api, format: 'json' do
    resources :groups
    resources :people
  end
end
