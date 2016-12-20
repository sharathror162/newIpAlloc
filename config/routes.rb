Rails.application.routes.draw do

  resources :devices

  post '/device/assign', to: 'devices#assign_ip_address'
  get '/device/assign/:id', to: 'devices#assign_ip_address'

  # For authtentication of the application
  match '/account/login', to: 'accounts#login', via: [:get, :post]
  get '/account/logout', to: 'accounts#logout'
  match '/account/signup', to: 'accounts#signup', via: [:get, :post]

  #For Account Activation
  get '/account/activate/:id', to: 'accounts#activate'
  match '/account/resend_activation', to: 'accounts#resend_activation', via: [:get, :post]

  #For Password Reset
  get'account/password_reset', to: 'accounts#password_reset'
  match 'account/reset_notice', to: 'accounts#reset_notice', via: [:get, :post]
  match 'account/reset_approved/:id', to: 'accounts#reset_approved', via: :all

  root 'pages#home'
  get 'about', to: 'pages#about'

end
