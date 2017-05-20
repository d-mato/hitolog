Rails.application.routes.draw do
  root 'home#index'
  devise_for :users

  namespace :api do
    resources :people
  end
end
