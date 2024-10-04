# frozen_string_literal: true

require "faker"

module Generator
  # Defines a method that can be used in rake tasks to generate notes.
  module Notes
    def self.create_note
      sample_tags = Faker::Lorem.words(number: 10)
      person_ids = (1..Person.count).map(&:to_s)

      has_date = [true, false].sample
      date = if has_date
               Faker::Date.between(from: 100.years.ago,
                                   to: Time.zone.today).strftime("%F")
             end

      tags = sample_tags.sample(rand(sample_tags.count)).join(", ")
      people_tags = person_ids.sample(rand(5)).join(", ")

      note = Note.new(title: Faker::Movies::LordOfTheRings.character,
                      rich_content: Faker::Lorem.paragraphs(number: 10).join("\n\n"),
                      date_string: date, tag_list: tags, tagged_person_list: people_tags)

      note.save!
    end
  end
end
