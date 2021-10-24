Rails.application.routes.draw do
  namespace :admin do
    root 'users#index'
    resources :users
  end
  devise_for :users
  resources :events do
    resources :items
  end
  get :about, to: 'about#index'
  get 'events/page/(:page(.:format))', to: 'events#index'
  root 'events#index'
end
