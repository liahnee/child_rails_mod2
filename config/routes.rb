Rails.application.routes.draw do
  resources :socializations
  resources :learnings
  resources :hobbies
  resources :jobs
  resources :create_personalities
  resources :user_children
  resources :create_children
  resources :create_users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/child/:id/post_update', to: 'children#post_update'
end
