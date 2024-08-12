Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['google_client_id'], ENV['google_client_secret'],
    {
      scope: 'email, profile, https://www.googleapis.com/auth/calendar.events.readonly',
      prompt: 'select_account',
    }
end
# OmniAuth.config.allowed_request_methods = %i[get]