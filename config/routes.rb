Rails.application.routes.draw do
  root 'application#index'

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

	namespace :users do
		resources :index, only: :user do
			get :user, on: :collection
		end
	end

  resources :books
end
