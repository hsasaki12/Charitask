# frozen_string_literal: true

# config/routes.rb
Rails.application.routes.draw do
  root 'home#index'

  resources :quests do
    collection do
      get :confirm
      post :create
      get :complete
    end
  end

  devise_for :users, path: '', path_names: {
    sign_in: 'signin',
    sign_out: 'signout',
    sign_up: 'signup'
  }
end
