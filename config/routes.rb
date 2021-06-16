Rails.application.routes.draw do
  root 'application#index'

  devise_for :users,
             controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  namespace :users do
    resources :index do
      get :me, on: :collection
    end
  end

  resources :posts
  patch 'posts/:id/readed', to: 'posts#close_reading_post'

  resources :books
  resources :categories
  resources :comments, only: :create
  resources :ratings, only: :create

  get '/*slug', to: 'application#index',
                constraints: ->(request) { !request.fullpath.include?('rails/active_storage') }
end
