Rails.application.routes.draw do
devise_for :users, skip: [:sessions, :registrations]

 as :user do
  get 'signin', to: 'devise/sessions#new', as: :new_user_session
  post 'signin', to: 'devise/sessions#create', as: :user_session
  delete 'signout', to: 'devise/sessions#destroy', as: :destroy_user_session
  get 'signup', to: 'devise/registrations#new', as: :new_user_registration
  post 'signup', to: 'devise/registrations#create', as: :user_registration
 end
end
