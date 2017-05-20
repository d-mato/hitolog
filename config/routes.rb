Rails.application.routes.draw do
  root 'home#index'
  devise_for :users

  namespace :api, format: 'json' do
    resources :groups
    resources :people
  end
end
