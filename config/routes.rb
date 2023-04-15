Rails.application.routes.draw do
  root 'tops#index'
  resources :users, only: %i[new create]
end
