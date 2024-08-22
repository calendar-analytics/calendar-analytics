require 'googleauth'
require 'googleauth/stores/file_token_store'

Rails.application.config.google_calendar = {
  client_id: Google::Auth::ClientId.from_hash(  {
    'web' => {
      'client_id' => ENV['google_client_id'],
      'client_secret' => ENV['google_client_secret']
    }
  }),
  scope: Google::Apis::CalendarV3::AUTH_CALENDAR_EVENTS_READONLY,
  token_store: Google::Auth::Stores::FileTokenStore.new(file: Rails.root.join('config', 'google_tokens.yml')),
}

Rails.application.config.google_calendar[:authorizer] = Google::Auth::WebUserAuthorizer.new(
  Rails.application.config.google_calendar[:client_id],
  Rails.application.config.google_calendar[:scope],
  Rails.application.config.google_calendar[:token_store],
  '/oauth2callback'
)
