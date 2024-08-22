class GoogleController < ApplicationController
  def index
    calendar = Google::Apis::CalendarV3::CalendarService.new
    print(calendar)
  end

  def calendar_list
    calendar = Google::Apis::CalendarV3::CalendarService.new
    page_token = nil
    begin
      result = client.list_calendar_lists(page_token: page_token)
      result.items.each do |e|
        print e.summary + "\n"
      end
      if result.next_page_token != page_token
        page_token = result.next_page_token
      else
        page_token = nil
      end
    end while !page_token.nil?
  end

  def redirect
    redirect_to Rails.application.config
                     .google_calendar[:authorizer]
                     .get_authorization_url(request: request), allow_other_host: true
  end

  def oauth2callback
    # target_url = Google::Auth::WebUserAuthorizer.handle_auth_callback_deferred(request)
    render json: {'item': 'worked?'}
  end
end
