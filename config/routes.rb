Rails.application.routes.draw do

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do  
    
    get 'login' => 'user_sessions#new', as: :login
    post 'logout' => 'user_sessions#destroy', as: :logout
    
    get 'user_sessions/new'
    get 'user_sessions/create'
    get 'user_sessions/destroy'

    namespace :dashboard do
      resources :cards
      resources :decks
    end

    resources :users
    resources :user_sessions

    post '/check' => 'dashboard/home#check'

    root 'dashboard/home#index'
    root to: 'users#index'

    post "oauth/callback" => "home/oauths#callback"
    get "oauth/callback" => "home/oauths#callback" # for use with Github, Facebook
    get "oauth/:provider" => "home/oauths#oauth", as: :auth_at_provider

    get 'switch_current_deck' => 'users#switch_current_deck'
  end
end
