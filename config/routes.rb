Rails.application.routes.draw do
  root to: 'home#index'

  get 'events', to: 'events#index'

  get 'events/:code', to: 'events#show', :as => 'event'

  get 'projects', to: 'events#projects', :as => 'events_projects'

  get 'events/:code/:project_name', to: 'project#index', :as => 'project'


  namespace :admin do
    root to: 'events#index'

    resources :users do
      member do
        get 'edit_password', to: 'users#edit_password'
        get 'equipes', to: 'users#equipes'
        patch 'user_password', to: 'users#update_password'
        put 'user_password', to: 'users#update_password'
      end
    end


    get 'home_configuration', to: 'home_configuration#index'

    patch 'home_configuration', to: 'home_configuration#update'
    put 'home_configuration', to: 'home_configuration#update'

    resources :events, param: :code do
      member do
        get 'event_subscribe', to: 'events#event_subscribe'
        resources :event_users, :path => 'users'
        resources :teams, as: :event_teams do
          resources :team_users, :path => 'members', :as => 'users'
          resources :projects
        end
      end
    end
  end

  devise_for :users
end
