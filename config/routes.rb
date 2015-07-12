Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: "pages#home"

  resources :games do
    resources :team_members, only: [:index, :create, :edit, :update, :destroy]
  end
end
