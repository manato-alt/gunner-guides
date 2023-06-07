Rails.application.routes.draw do
  namespace :admin do
    root to: 'users#index'
    resources :users, only: %i[show destroy]
    resources :games, only: %i[index show edit update destroy]
    resources :videos, only: %i[index show edit update destroy]
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
  end
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
      resources :purposes, only: [:show]
    end
  end
  resources :uservideos, only: [:update]
  get 'home/:id', to: 'uservideos#home', as: 'home'
  get 'memo_section/:id', to: 'memos#memo', as: 'memo_section'
  resources :memos, only: %i[create edit update destroy]
end
