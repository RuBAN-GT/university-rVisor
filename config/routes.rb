Rails.application.routes.draw do
  # public pages
  root "public#index"

  get "about", to: "public#about"

  # control panel
  get "cp", to: "control_panel#index"

  # pages
  resources :pages

  # users
  resources :users
  put "users/:id/confirm(.:format)", as: "user_manual_confirm", to: "users#confirm"

  # services
  resources :services

  # tests
  resources :tests do
    get 'heatmap', to: "tests#show_heatmap"

    resources :passages do
      get 'heatmap', to: "passages#show_heatmap"
    end
  end

  # authentication and near actions
  devise_for :users, path: "auth", skip: :registrations
  devise_scope :user do
    resource :registration,
             only:       [:new, :create],
             path:       "auth",
             path_names: { new: "sign_up" },
             controller: "devise/registrations",
             as:         :user_registration do
      get :cancel
    end
  end
  devise_scope :user do
    resource :registration,
             only:       [:edit, :update],
             path:       "cp/profile",
             path_names: { edit: "settings" },
             controller: "devise/registrations",
             as:         :user_registration do
      get :cancel
    end
  end
end
