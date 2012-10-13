R12Team365::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks', registrations: 'users/registrations', passwords: 'users/passwords' }

  get 'users/profile/:username', to: 'users/profile#show', as: :profile

  resources :projects

  get 'pages/:action', to: 'pages', action: /[a-z-]+/, as: :page
  root to: 'pages#root'
end
