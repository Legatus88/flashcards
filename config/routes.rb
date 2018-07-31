Rails.application.routes.draw do

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do  
    get 'oauths/oauth'
    get 'oauths/callback'
    get 'login' => 'user_sessions#new', as: :login
    post 'logout' => 'user_sessions#destroy', as: :logout
    
    get 'user_sessions/new'
    get 'user_sessions/create'
    get 'user_sessions/destroy'

    resources :cards
    resources :users
    resources :user_sessions
    resources :decks

    post '/check' => 'home#check'

    root 'home#index'
    root to: 'users#index'

    post "oauth/callback" => "oauths#callback"
    get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
    get "oauth/:provider" => "oauths#oauth", as: :auth_at_provider

    get 'switch_current_deck' => 'users#switch_current_deck'
  end
end
