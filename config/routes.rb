Rails.application.routes.draw do
  resources :main_children
  resources :socializations
  resources :learnings
  resources :hobbies
  resources :jobs
  resources :personalities
  resources :users do 
    resources :children 
  end


  patch 'user/:user_id/children/:id', to: 'children#update'
  root :to => redirect('/users/new')
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end