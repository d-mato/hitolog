Rails.application.routes.draw do
  root 'application#index'
  get 'sign_in' => 'sessions#new'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  namespace :api, format: 'json' do
    resources :groups
    resources :people, shallow: true do
      resources :impressions, only: [:create, :update, :destroy]
    end
  end
end
