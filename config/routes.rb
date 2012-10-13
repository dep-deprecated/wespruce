R12Team365::Application.routes.draw do
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' },
    controllers: {
      omniauth_callbacks: 'omniauth_callbacks',
      registrations:      'users/registrations',
      passwords:          'users/passwords'
    }

  resources :projects

  get 'pages/:action', to: 'pages', action: /[a-z-]+/, as: :page
  root to: 'pages#root'
end
