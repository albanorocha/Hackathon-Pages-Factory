Rails.application.routes.draw do
  root to: 'home#index'

  get 'events', to: 'events#index'

  get 'events/:code', to: 'events#show', :as => 'event'

  get 'events/projects', to: 'events#projects', :as => 'events_projects'

  get 'events/:code/:project_name', to: 'project#index', :as => 'project'


  namespace :admin do
    root to: 'dashboard#index'

    resources :users

    resources :events, param: :code do
      member do
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
