Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create, :show, :destroy], param: :username do
    get 'activate', on: :collection
  end
  get '/users', to: 'users#new'
  
  resource :session, only: [:new, :create, :destroy]
  get '/session', to: 'sessions#new'

  resources :subs, except: [:destroy], param: :title

  resources :posts, except: [:index] do
    resources :comments, only: [:new]
  end
  get '/posts', to: 'subs#index'

  resources :comments, only: [:create]

  resources :pages, only: [:index]

  root 'pages#index'
end
