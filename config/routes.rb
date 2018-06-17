Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'
  get '/cards' => 'cards_controller#index'
  get '/cards/:id' => 'cards_controller#show'
end
