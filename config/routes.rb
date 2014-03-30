PhotoChallenge::Application.routes.draw do
  root 'challenges#index'

  devise_for :users, :controllers => {:omniauth_callbacks => 'omniauth_callbacks', :registrations => 'registrations'}
  resources :challenges do
    member do
      put :vote, :defaults => {format: :json}
    end
  end

  resources :users
  resources :photos
end
