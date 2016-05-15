Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'pages#index'

  devise_for :users, :path => :account, :controllers => { :registrations => :registrations }

  get '/tests' => 'tests#all'
  resources :services do
    resources :tests do
      resources :results, :only => [:index, :show, :destroy]
    end
  end

  put    '/screens'  => 'screens#create'
  patch  '/screens'  => 'screens#create'
  resources :screens, :only => [:index, :create, :destroy]

  resources :results, :path => '/research', :controller => :research, :only => [:index, :show, :new, :create]
end
