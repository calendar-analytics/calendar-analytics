Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Defines the root path route ("/")
  # root "posts#index"
  root "application#cookie"
  namespace :api do
    namespace :v1 do
      resources :test
      resources :calendars, only: [:index]
      get "events/*calendar_id", to: "events#index", calendar_id: "/[^\/]+/"
    end
  end

  get "/auth/google_oauth2", to: "auth#redirect"
  get "/auth/google_oauth2/callback", to: "auth#callback"
end
