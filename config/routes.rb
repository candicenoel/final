Rails.application.routes.draw do
  devise_for :users
  root "places#index"
  resources :places, only: [:new, :create, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
