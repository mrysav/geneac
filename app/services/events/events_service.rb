# frozen_string_literal: true

module Events
  # Service in charge of returning events in a person's life.
  class EventsService
    def initialize(params)
      @person = Person.find(params[:id])
    end

    def events
      events = []

      unless @person.birth_date.nil?
        events.push(Event.new(title: 'Born', date: @person.birth_date,
                              location: @person.birthplace))
      end

      unless @person.death_date.nil?
        events.push(Event.new(title: 'Burial', date: @person.death_date,
                              location: @person.burialplace))
      end

      events
    end
  end
end
