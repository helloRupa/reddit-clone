Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create, :show, :destroy] do
    get 'activate', on: :collection
  end
  
  resource :session, only: [:new, :create, :destroy]
end
