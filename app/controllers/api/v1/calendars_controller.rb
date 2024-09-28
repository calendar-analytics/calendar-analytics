module Api
  module V1
    class CalendarsController < ApplicationController
      before_action :initialize_client

      def index
        @client.update!(session[:authorization])
        service = Google::Apis::CalendarV3::CalendarService.new
        service.authorization = @client
        @calendar_list = service.list_calendar_lists
        render json: {'calendar-list': @calendar_list}
      rescue Google::Apis::AuthorizationError
        refresh_and_retry { @calendar_list = service.list_calendar_lists }
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

      def refresh_and_retry
        response = @client.refresh!
        session[:authorization] = session[:authorization].merge(response)
        yield
      rescue StandardError => e
        # Handle error (e.g., log it, show error message)
        print("Failed to fetch data: #{e.message}")
        render json: { error: e.message }
      end
    end
  end
end
