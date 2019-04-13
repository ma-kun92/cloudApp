Rails.application.routes.draw do
  root 'users#index'
  get 'user_sessions/new', as: 'login'
  get 'user_sessions/destroy', as: 'logout'
  resource :users do
    resource :card, only: [:new, :create, :show, :destroy]
  end

  resources :user_sessions
  resources :groups do
    resources :projects do
      resources :payments
      collection do
        post 'pay'
        post 'pay_card'
      end
      resources :messages
    end
  end

end
