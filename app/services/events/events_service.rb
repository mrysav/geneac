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
        events.push(Event.new(title: 'Birth', date: @person.birth_date,
                              date_string: @person.birth_date_string,
                              location: @person.birthplace))
      end

      unless @person.death_date.nil?
        events.push(Event.new(title: 'Death', date: @person.death_date,
                              date_string: @person.death_date_string,
                              location: @person.burialplace))
      end

      @person.facts.each do |fact|
        events.push(Event.new(title: fact.fact_type, date: fact.date,
                              date_string: fact.date_string,
                              location: fact.place))
      end

      events.sort.reverse
    end
  end
end
