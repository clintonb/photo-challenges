PhotoChallenges::Application.routes.draw do
  root 'daily_challenges#latest'

  devise_for :users, :controllers => {:omniauth_callbacks => 'omniauth_callbacks', :registrations => 'registrations'}
  resources :challenges do
    member do
      put :vote, :defaults => {format: :json}
    end
  end

  resources :users
  resources :photos
  resources :daily_challenges, path: 'daily-challenges' do
    collection do
      get :latest
    end
  end
end
