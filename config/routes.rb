Rails.application.routes.draw do
  namespace :admin do
    root 'users#index'
    resources :users do
      member do
        post :toggle, action: :toggle
      end
    end
  end
  devise_for :users
  resources :events do
    resources :items
  end
  get :about, to: 'about#index'
  post :toggle, to: 'locales#toggle'

  get 'events/page/(:page(.:format))', to: 'events#index'
  root 'events#index'
end
