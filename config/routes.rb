Rails.application.routes.draw do
  resources :sessions, only: [:create, :destroy]
  get '/sessions/new', to: 'sessions#new', as: '/login'
  resources :main_children
  resources :socializations
  resources :learnings
  resources :hobbies
  resources :jobs
  resources :users do 
    resources :children do
      resources :personalities #breaking the rule of thumb!
    end
  end
  patch '/users/:user_id/children/:id/independence' => 'children#independence', as: :independence
  root to: 'sessions#new'

  #'application#redirect_to_user_new'
end