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

  namespace :admin do
    resources :posts
  end
end
