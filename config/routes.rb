Rails.application.routes.draw do
  get 'games/index'
  root 'tops#index'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  resources :users, only: %i[new create]
  resources :games, only: %i[index show], param: :title do
    member do
      get 'setting', to: 'purposes#setting'
      get 'training', to: 'purposes#training'
      get 'information', to: 'purposes#information'
    end
  end
end
