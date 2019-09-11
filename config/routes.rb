Rails.application.routes.draw do
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
  root to: 'application#redirect_to_user_new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end