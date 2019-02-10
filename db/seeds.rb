# frozen_string_literal: true

require 'open-uri'
require 'faker'

case Rails.env
when 'development'

  User.all.each(&:destroy!)
  ActiveRecord::Base.connection.reset_pk_sequence!(User.table_name)

  User.create!(name: 'Marty McFly', email: 'mcfly@bttf.net',
               password: 'thatsheavy', password_confirmation: 'thatsheavy',
               admin: true)

  puts 'Created test admin account'

  User.create!(name: 'Lorraine McFly', email: 'lorraine@bttf.net',
               password: 'calvink', password_confirmation: 'calvink',
               admin: false)

  puts 'Created test user account'

  sample_tags = Faker::Lorem.words(10)

  Person.all.each(&:destroy!)
  ActiveRecord::Base.connection.reset_pk_sequence!(Person.table_name)

  single_females = []
  single_males = []
  parents = []

  100.times do |_index|
    is_female = [true, false].sample
    person = Person.create!(first_name: is_female ? Faker::Name.female_first_name : Faker::Name.male_first_name,
                            last_name: Faker::Name.last_name,
                            gender: is_female ? 'Female' : 'Male',
                            bio: Faker::FamousLastWords.last_words
                           )

    is_new_branch = rand(7) <= 1

    if is_new_branch
      spouse = single_females.pop unless is_female
      spouse = single_males.pop if is_female

      if spouse
        person.current_spouse_id = spouse

        spouse_record = Person.find(spouse)
        spouse_record.current_spouse_id = person.id
        spouse_record.save!

        parents.push [person.id, spouse] if is_female
        parents.push [spouse, person.id] unless is_female
      end
    else
      mom_and_pop = parents.pop
      if mom_and_pop
        person.mother_id = mom_and_pop[0]
        person.father_id = mom_and_pop[1]
        parents.push mom_and_pop
      end
    end

    unless person.current_spouse_id
      single_females.push person.id if is_female
      single_males.push person.id unless is_female
    end

    has_birthday = [true, false].sample
    has_deathday = [true, false].sample

    if has_birthday
      person.date_of_birth = Faker::Date.birthday(0, 100).strftime('%F')
      person.birthplace = Faker::Address.city + ', ' + Faker::Address.country
    end

    if has_deathday
      person.date_of_death = Faker::Date.between(person.date_of_birth || 50.years.ago, Date.today).strftime('%F')
      person.burialplace = Faker::Address.city + ', ' + Faker::Address.country
    end

    person.save!
  end
  puts "Created #{Person.count} people"
  ## For debugging
  # p "Single females: #{single_females.count}"
  # p "Single males: #{single_males.count}"
  # p "Available sets of parents: #{parents.count}"

  Photo.all.each(&:destroy!)
  ActiveRecord::Base.connection.reset_pk_sequence!(Photo.table_name)

  person_ids = (1..Person.count).map(&:to_s)

  20.times do |_index|
    has_date = [true, false].sample
    date = has_date ? Faker::Date.between(100.years.ago, Date.today).strftime('%F') : ''
    tags = sample_tags.sample(rand(sample_tags.count)).join(', ')
    people_tags = person_ids.sample(rand(5)).join(', ')
    photo = Photo.create!(title: Faker::BackToTheFuture.character,
                          description: Faker::BackToTheFuture.quote,
                          date: date, tag_list: tags, tagged_person_list: people_tags)
    downloaded_img = open(Faker::LoremFlickr.image)
    photo.image.attach(io: downloaded_img, filename: "photo_#{photo.id}.jpg")
  end
  puts "Created #{Photo.count} photos"

  Note.all.each(&:destroy!)
  ActiveRecord::Base.connection.reset_pk_sequence!(Note.table_name)

  50.times do |_index|
    has_date = [true, false].sample
    date = has_date ? Faker::Date.between(100.years.ago, Date.today).strftime('%F') : ''
    tags = sample_tags.sample(rand(sample_tags.count)).join(', ')
    people_tags = person_ids.sample(rand(5)).join(', ')
    Note.create!(title: Faker::LordOfTheRings.character,
                 content: Faker::Lorem.paragraphs(10).join("\n\n"),
                 date: date, tag_list: tags, tagged_person_list: people_tags)
  end
  puts "Created #{Note.count} notes"
end
