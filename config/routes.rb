Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  resources :components, only: %i[index show new create edit update]
  resources :assemblies, only: %i[index new create edit update]
  resources :suppliers do
    resources :supplier_skus, path: "skus", only: %i[index new create edit update destroy]
  end
  resources :decks, only: %i[index show new create edit update destroy] do
    resources :cards, only: %i[new create show destroy] do
      get :available_assemblies, on: :member
    end
    resources :card_assemblies, only: %i[create destroy] do
      patch :move, on: :member
    end
  end

  # Defines the root path route ("/")
  root "components#index"
end
