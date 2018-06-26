Rails.application.routes.draw do

  resources :cards
  post '/check' => 'home#check'
  
  root 'home#index'
end
