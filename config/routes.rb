Rails.application.routes.draw do
  devise_for :users
  get "welcome/say_hello" => "welcome#say"
  get "welcome" => "welcome#index"

  root :to => "welcome#index"
  resources :posts do
    post 'check'
    resources :comments
  end
  resources :categories, except: :show

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
end
