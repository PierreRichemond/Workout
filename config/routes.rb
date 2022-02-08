Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: "registrations" }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  get 'homes/index'
  resources :users do
    resources :exercises
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#index"
  resources :homes, only: [:index] do
    collection do
      post :search, to: 'homes#search'
    end
  end

  resources :friendships, only: [:show, :create, :destroy]
  resources :messages, only: [:create]
end
