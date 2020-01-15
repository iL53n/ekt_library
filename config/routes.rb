Rails.application.routes.draw do
  root 'application#index'

  devise_for :users,
             controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  namespace :users do
    resources :index do
      get :me, on: :collection
    end
  end

  resources :books do
    patch :readed, to: 'posts#close_reading_post'
  end

  resources :posts
  resources :categories

  get '/*slug', to: 'application#index'
end
