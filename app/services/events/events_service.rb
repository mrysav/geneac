# frozen_string_literal: true

module Events
  # Service in charge of returning events in a person's life.
  class EventsService
    def initialize(params)
      @person = Person.find(params[:id])
    end

    def events
      events = []

      unless @person.date_of_birth.nil?
        events.push(Event.new(title: 'Born', date: @person.date_of_birth,
                              location: @person.birthplace))
      end

      unless @person.date_of_death.nil?
        events.push(Event.new(title: 'Burial', date: @person.date_of_death,
                              location: @person.burialplace))
      end

      events
    end
  end
end
