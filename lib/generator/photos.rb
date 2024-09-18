# frozen_string_literal: true

require "faker"

module Generator
  # Defines a method that can be used in rake tasks to generate photos.
  module Photos
    def self.create_photo
      sample_tags = Faker::Lorem.words(number: 10)
      person_ids = (1..Person.count).map(&:to_s)

      has_date = [true, false].sample
      date = if has_date
               Faker::Date.between(from: 100.years.ago,
                                   to: Time.zone.today).strftime("%F")
             end

      tags = sample_tags.sample(rand(sample_tags.count)).join(", ")
      people_tags = person_ids.sample(rand(5)).join(", ")

      photo = Photo.new(title: Faker::Movies::BackToTheFuture.character,
                        description: Faker::Movies::BackToTheFuture.quote,
                        date_string: date, tag_list: tags, tagged_person_list: people_tags)

      downloaded_img = URI.parse(Faker::LoremFlickr.image).open
      photo.image.attach(io: downloaded_img, filename: "photo_#{photo.id}.jpg")
      photo.save!
    end
  end
end
