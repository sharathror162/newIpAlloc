Rails.application.routes.draw do
  resources :devices

  post '/device/assign', to: 'devices#assign_ip_address'
  get '/device/assign/:id', to: 'devices#assign_ip_address'

  # For authtentication of the application
  match '/account/login', to: 'accounts#login', via: [:get, :post]
  get '/account/logout', to: 'accounts#logout'
  match '/account/signup', to: 'accounts#signup', via: [:get, :post]

  root 'devices#index'

end
