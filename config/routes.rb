Rails.application.routes.draw do
  resources :tickets, except: [:new, :edit, :destroy] do
    resources :comments, only: [:create]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]
end
