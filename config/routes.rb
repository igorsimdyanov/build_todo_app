Rails.application.routes.draw do
  get 'about', to: 'about#index', as: 'about_index'
  get 'about/params(/:hello)', to: 'about#index'
  root 'events#index'
end
