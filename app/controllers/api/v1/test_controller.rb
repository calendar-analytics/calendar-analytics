class Api::V1::TestController < ApplicationController
  def index
    file_path = Rails.root.join('sample.json')
    @data = File.read(file_path)

    render json: @data
  end
end
