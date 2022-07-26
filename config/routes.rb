Rails.application.routes.draw do
  devise_for :users
  constraints(ClientDomainConstraint.new) do
    get "welcome/say_hello" => "welcome#say"
    get "welcome" => "welcome#index"

    root :to => "welcome#index"
    resources :posts do
      post 'check'
      resources :comments
    end
    resources :categories, except: :show
  end
  constraints(AdminDomainConstraint.new) do
    namespace :admin do
      resources :posts do
        post 'publish'
      end
    end
  end

  namespace :api do
    resources :regions, only: :index, defaults: { format: :json }
    resources :provinces, only: :index, defaults: { format: :json }
  end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
