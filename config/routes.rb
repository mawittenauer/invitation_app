Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users
  
  resources :events do
    resources :invitations, only: [:create]
  end
  
  resources :invitees, only: [:create]
  
  get '/rsvp/:token', to: 'invitations#rsvp', as: 'rsvp_invitation'
  patch '/rsvp/:token', to: 'invitations#update_rsvp'
  
  root 'events#index'
end
