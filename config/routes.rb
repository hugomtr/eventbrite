Rails.application.routes.draw do
  get 'static_pages/secret'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "static_pages#index"
  resources :events
  resources :users ,only: [:index,:show]
end


