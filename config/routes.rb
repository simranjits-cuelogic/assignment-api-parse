Rails.application.routes.draw do
  resources :restaurants, only: [:index]

  resources :sessions, only: [], path: '' do
    collection do
      get 'signup'
      post 'create_signup'
      get 'login'
      post 'create_login'
      delete 'logout'
    end
  end

  resources :dashboards, only: [:index]

  root 'restaurants#index'
end
