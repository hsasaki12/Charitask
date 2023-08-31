# frozen_string_literal: true

# config/routes.rb
Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, controllers: { sessions: 'users/sessions' }


  resources :quests do
    collection do
      get :confirm
      get :complete
    end

    member do
      post :update_confirm
    end
  end
end
