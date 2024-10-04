# frozen_string_literal: true

require "faker"

module Generator
  # Methods that can be used by Rake tasks to generate fake people.
  module People
    def self.create_person
      person = Person.new(first_name: [true, false].sample ? Faker::Name.female_first_name : Faker::Name.male_first_name,
                          last_name: Faker::Name.last_name,
                          gender: ["", "male", "female", "transgender",
                                   "gender neutral", "non-binary", "agender", "polygender"].sample,
                          sex: ["", "male", "female"].sample,
                          bio: Faker::Quote.famous_last_words)

      has_birthday = [true, false].sample
      has_deathday = [true, false].sample

      if has_birthday
        f = Fact.new
        f.fact_type = "birth"
        f.factable = person
        f.date_string = Faker::Date.birthday(min_age: 0, max_age: 100).strftime("%F")
        f.place = "#{Faker::Address.city}, #{Faker::Address.country}"
        f.save!
        person.birth_fact_id = f.id
      end

      if has_deathday
        f = Fact.new
        f.fact_type = "death"
        f.factable = person
        f.date_string =
          Faker::Date.between(from: person.birth_date || 50.years.ago,
                              to: Time.zone.today).strftime("%F")
        f.place = "#{Faker::Address.city}, #{Faker::Address.country}"
        f.save!
        person.death_fact_id = f.id
      end

      person.save!
      person
    end

    def self.create_family(count: 100, branchiness: 7)
      single_females = []
      single_males = []
      parents = []

      count.times do
        person = create_person
        is_female = person.sex == "female"

        create_new_branch = rand(branchiness) <= 1

        if create_new_branch
          spouse = single_females.pop unless is_female
          spouse = single_males.pop if is_female

          if spouse
            person.current_spouse_id = spouse

            spouse_record = Person.find(spouse)
            spouse_record.current_spouse_id = person.id
            spouse_record.save_without_history!

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

        person.save!
      end
    end
  end
end
