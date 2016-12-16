Rails.application.routes.draw do
  resources :devices

  match '/device/assign', to: 'devices#assign_ip_address', via: :post
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/device/assign/:id', to: 'devices#assign_ip_address'
  root 'devices#index'
end
