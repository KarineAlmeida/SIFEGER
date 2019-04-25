Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  resource :users, only: [] do
    resources :invitations, module: :users, only: :index do
      resource :statuses, module: :invitations, only: :update
    end
  end

  resource :dashboard, only: :show, module: :users

  resources :use_cases, only: :index

  resources :projects do
    resource :statuses, only: :update, module: :projects
    resources :invitations, only: %w[index new create destroy], module: :projects
    resources :requisites, module: :projects do
      resource :versions, module: :requisites, only: [:new, :create] do
        get :index, on: :collection
      end
      resource :responsable, only: :update, module: :requisites
      resource :statuses,    only: :update, module: :requisites
    end
    resources :profiles, module: :projects, only: [:edit, :update]
    resource :choice, only: :create, module: :projects
  end

  resource :invitations, only: [] do
    resource :acceptances, module: :invitations, only: [:new, :create]
  end


  root to: 'users/dashboards#show'
end
