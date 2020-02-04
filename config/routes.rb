Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :events do
    resources :rounds do
      resources :games
        resources :teams
      resources :players
    end
    resources :players
  end

  root 'events#index'
end
