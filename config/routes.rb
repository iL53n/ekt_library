Rails.application.routes.draw do
  root 'application#index'

  devise_for :users, controllers: { sessions: 'users/sessions' }

  resources :books

end
