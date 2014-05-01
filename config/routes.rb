GATest::Application.routes.draw do
  resources :uploads, only: [:new, :create]
  resources :accounts, only: [:index]
  get '/auth/:provider/callback', to: 'accounts#create'
end
