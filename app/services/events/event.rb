# frozen_string_literal: true

module Events
  # Event model object.
  class Event
    attr_reader :title
    attr_reader :location
    attr_reader :date

    def initialize(params)
      @title = params[:title]
      @location = params[:location]
      @date = params[:date]&.strftime('%F')
    end
  end
end
