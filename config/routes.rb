Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'create-user', to: "authenticate#create", constraints: { format: 'json' }
  post 'login', to: "authenticate#login",constraints: { format: 'json' }
  get 'profile', to: "authenticate#profile",constraints: { format: 'json' }
end
