class Api::V1::TestController < ApplicationController
  def index
    @data = {
      "items": [
        {
          "id": "event_id_1",
          "summary": "Team Meeting",
          "description": "Weekly team sync-up meeting",
          "start": {
            "dateTime": "2024-08-05T10:00:00-04:00",
            "timeZone": "America/Toronto"
          },
          "end": {
            "dateTime": "2024-08-05T11:00:00-04:00",
            "timeZone": "America/Toronto"
          },
        }
      ]
    }

    render json: @data
  end
end
