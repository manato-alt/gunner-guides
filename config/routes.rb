Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  get 'password_resets/create'
  get 'password_resets/edit'
  get 'password_resets/update'
  get 'password_resets/new'
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
  get 'playlist_section/:id', to: 'playlists#playlist', as: 'playlist_section'
  resources :memos, only: %i[create edit update destroy]
  resources :mypages, only: %i[index]
  get 'watch', to: 'mypages#watch', as: 'watch'
  get 'complete', to: 'mypages#complete', as: 'complete'
  get 'mypage_memo', to: 'mypages#memo', as: 'mypage_memo'
  get 'mypage_playlist', to: 'mypages#playlist', as: 'mypage_playlist'
  resources :playlists do
    member do
      put 'add_video/:video_id', to: 'playlists#add_video', as: 'add_video'
    end
  end
  get '/autocomplete', to: 'games#autocomplete'
  resources :password_resets, only: %i[create edit update new]
end
