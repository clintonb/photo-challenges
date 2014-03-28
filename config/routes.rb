PhotoChallenge::Application.routes.draw do
  root 'challenges#index'

  devise_for :users, :controllers => {:omniauth_callbacks => 'omniauth_callbacks', :registrations => 'registrations'}
  resources :challenges
  resources :users
end
