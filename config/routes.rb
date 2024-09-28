Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api do
    namespace :v1 do
      resources :test
    end
  end

  get "/redirect", to: "calendars#redirect"
  get "/callback", to: "calendars#callback"

  get "/calendars", to: "calendars#calendars"
  # Get time specific events
  # http://localhost:3000/events/primary?time_min=2024-08-01&time_max=2024-09-20
  get "/events/*calendar_id", to: "calendars#events", as: "events", calendar_id: "/[^\/]+/"

  root to: 'application#cookie'
end
