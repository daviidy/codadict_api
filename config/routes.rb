Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :projects do
    resources :proposals
  end

  post 'auth/login', to: 'authentication#authenticate'

  post 'signup', to: 'users#create'

  # get 'projects/all', to 'projects#all'
end
