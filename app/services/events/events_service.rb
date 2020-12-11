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
        events.push(Event.new(title: fact.fact_type.capitalize, date: fact.date,
                              date_string: fact.date_string&.capitalize,
                              location: fact.place, citations: fact.citations,
                              tagged_people: fact.resolved_people))
      end

      Fact.tagged_with(@person.id.to_s).each do |fact|
        title = "#{fact.fact_type.capitalize} (#{fact.factable.title})" if fact.factable
        title_link = fact.factable.friendly_url if fact.factable
        title = fact.fact_type.capitalize unless fact.factable

        events.push(Event.new(title: title, title_link: title_link, date: fact.date,
                              date_string: fact.date_string&.capitalize,
                              location: fact.place, citations: fact.citations,
                              tagged_people: fact.resolved_people))
      end

      Photo.tagged_with(@person.id.to_s).each do |photo|
        next unless photo.date

        events.push(Event.new(title: photo.title, title_link: photo.url_path,
                              date: photo.date, date_string: photo.date_string&.capitalize,
                              preview_photo_attachment: photo.image))
      end

      Note.tagged_with(@person.id.to_s).each do |note|
        next unless note.date

        events.push(Event.new(title: note.title, title_link: note.url_path, date: note.date,
                              date_string: note.date_string&.capitalize))
      end

      events.sort
    end
  end
end
