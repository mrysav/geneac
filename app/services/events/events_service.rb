# frozen_string_literal: true

module Events
  # Service in charge of returning events in a person's life.
  class EventsService
    def initialize(params)
      @person = Person.find(params[:id])
    end

    def events
      events = []

      @person.facts.each do |fact|
        events.push(Event.new(title: fact.fact_type, date: fact.date,
                              date_string: fact.date_string&.capitalize,
                              location: fact.place))
      end

      events.sort.reverse
    end
  end
end
