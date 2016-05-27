Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'pages#index'

  devise_for :users, :path => :account, :controllers => { :registrations => :registrations }

  get '/tests' => 'tests#all'
  resources :services do
    resources :tests
  end

  put    '/screens'  => 'screens#create'
  patch  '/screens'  => 'screens#create'
  resources :screens, :only => [:index, :create, :destroy]

  resources :results, :path => '/research', :as => :research, :controller => :research, :only => [:index, :show, :destroy]
  get '/research/test/:test_id/new' => 'research#new', :as => :new_research
  post '/research/test/:test_id' => 'research#create', :as => :create_research
  get '/research/test/:test_id' => 'research#results', :as => :test_results
end
