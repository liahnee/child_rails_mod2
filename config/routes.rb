Rails.application.routes.draw do
  resources :sessions, only: [:create, :destroy]
  get '/sessions/new', to: 'sessions#new', as: '/login'
  resources :socializations
  resources :learnings
  resources :hobbies
  resources :jobs
  resources :users do 
    resources :children do
      resources :main_children, only: [:show, :new, :destroy]
      post '/user/:user_id/children/:child_id' => 'main_children#create', as: :new_main_child
      resources :personalities #breaking the rule of thumb!
    end
  end
  patch '/users/:user_id/children/:id/independence' => 'children#independence', as: :independence
  root to: 'sessions#root', as: :home
end