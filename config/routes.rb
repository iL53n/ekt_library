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
    # get :reserved, on: :collection
    # get :readed, on: :collection
    # get :reading, on: :collection
    # get :wishlist, on: :collection

    # member do
    #   patch :booking, :give_out, :return, :add_wish
    # end
  end

  resources :posts
  resources :categories

  get '/*slug', to: 'application#index'
end
