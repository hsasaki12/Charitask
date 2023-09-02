# frozen_string_literal: true

# config/routes.rb
Rails.application.routes.draw do
  get 'accounts/show'
  root 'home#index'
  devise_for :users, controllers: { sessions: 'users/sessions' }
  get 'account', to: 'accounts#show', as: 'account'

  resources :quests do
    collection do
      get :confirm
      get :complete
    end
  
    member do
      post :update_confirm
      post 'accept', to: 'status#accept'
    end
  
    resources :messages, only: [:index, :create]
  end
end
