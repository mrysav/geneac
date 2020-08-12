# frozen_string_literal: true

module Events
  # Event model object.
  class Event
    attr_reader :title, :title_link, :location, :date, :date_string, :preview_photo_attachment

    def initialize(params)
      @title = params[:title]
      @title_link = params[:title_link]
      @location = params[:location]
      @date = params[:date]
      @date_string = params[:date_string]
      @preview_photo_attachment = params[:preview_photo_attachment]
    end

    def <=>(other)
      if date && other&.date
        date <=> other.date
      else
        -1
      end
    end
  end
end
