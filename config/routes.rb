Rails.application.routes.draw do
  resources :tickets, only: [:index, :show, :create] do
    resources :comments, only: [:create]
  end

  namespace :agent do
    resources :tickets, only: [:index, :show, :update]
  end

  namespace :admin do
    resources :users, except: [:new, :edit, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]

  # Make this your last route.
  # this is for unmatched routes
  match '*unmatched_route', :to => 'application#raise_not_found!', :via => :all
end
