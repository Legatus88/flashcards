Rails.application.routes.draw do
  get 'home/index'

  resources :cards

  root 'home#index'

  get '/cards' => 'cards_controller#index'
  get '/cards/:id' => 'cards_controller#show'

  get '/add_card' => 'cards_controller#new'
  post '/cards' => 'cards_controller#create'
  
  get '/cards/:id/edit' => 'cards_controller#edit'
  patch '/cards/:id' => 'cards_controller#update'
  put '/cards/:id' => 'cards_controller#update'

  delete '/cards/:id' => 'cards_controller#destroy'
end
