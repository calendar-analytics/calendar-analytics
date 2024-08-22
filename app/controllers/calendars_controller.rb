class CalendarsController < ApplicationController
  before_action :initialize_client, only: [:redirect, :callback, :calendars, :events]
  # implement Google::Auth::Stores::FileTokenStore
  def redirect
    redirect_to @client.authorization_uri.to_s, allow_other_host: true
  end

  def callback
    @client.code = params[:code]
    response = @client.fetch_access_token!
    session[:authorization] = response
    redirect_to calendars_url
  rescue StandardError => e
    # Handle error (e.g., log it, show error message)
    redirect_to root_path, alert: "Failed to authorize: #{e.message}"
  end

  # list of calendars in which either the user will have to choose or we will use all of them
  def calendars
    @client.update!(session[:authorization])
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = @client
    @calendar_list = service.list_calendar_lists
    render json: {'calendar-list': @calendar_list}
  rescue Google::Apis::AuthorizationError
    refresh_and_retry { @calendar_list = service.list_calendar_lists }
  end

  # gets all events from a specific calendar 
  def events
    @client.update!(session[:authorization])
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = @client
    @event_list = service.list_events(params[:calendar_id])
    render json: @event_list
  rescue Google::Apis::AuthorizationError
    refresh_and_retry { @event_list = service.list_events(params[:calendar_id]) }
  end

  private

  def initialize_client
    @client = Signet::OAuth2::Client.new(client_options)
    print(@client)
  end

  def client_options
    {
      client_id: ENV["google_client_id"],
      client_secret: ENV["google_client_secret"],
      authorization_uri: "https://accounts.google.com/o/oauth2/auth",
      token_credential_uri: "https://oauth2.googleapis.com/token",
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY,
      redirect_uri: callback_url
    }
  end

  def refresh_and_retry
    response = @client.refresh!
    session[:authorization] = session[:authorization].merge(response)
    yield
  rescue StandardError => e
    # Handle error (e.g., log it, show error message)
    redirect_to root_path, alert: "Failed to fetch data: #{e.message}"
  end
end
