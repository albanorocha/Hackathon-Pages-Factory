Rails.application.routes.draw do

  namespace :admin do
    root to: 'dashboard#index'

    get 'dashboard/index'

    resources :admins

    resources :events
  end

  root to: 'visitors#index'
  devise_for :users
end
