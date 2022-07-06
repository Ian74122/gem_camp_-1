Rails.application.routes.draw do
  devise_for :users
  get "welcome/say_hello" => "welcome#say"
  get "welcome" => "welcome#index"

  root :to => "welcome#index"
  resources :posts do
    resources :comments
  end
end
