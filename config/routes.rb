Rails.application.routes.draw do
  resources :devices

  match '/device/assign', to: 'devices#assign_ip_address', via: :all
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
