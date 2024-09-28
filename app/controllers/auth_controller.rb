class AuthController < ApplicationController
  before_action :initialize_client

  def redirect
    redirect_to @client.authorization_uri.to_s, allow_other_host: true
  end

  def callback
    @client.code = params[:code]
    response = @client.fetch_access_token!
    session[:authorization] = response
    redirect_to "http://localhost:5173"
  rescue StandardError => e
    render json: { error: "Failed to authorize: #{e.message}" }, status: :unauthorized
  end

  private

  def initialize_client
    @client = Signet::OAuth2::Client.new(client_options)
  end

  def client_options
    {
      client_id: ENV["google_client_id"],
      client_secret: ENV["google_client_secret"],
      authorization_uri: "https://accounts.google.com/o/oauth2/auth",
      token_credential_uri: "https://oauth2.googleapis.com/token",
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY,
      redirect_uri: auth_google_oauth2_callback_url
    }
  end
end
