# frozen_string_literal: true

require "rails_helper"
require "person_spec_helper"

RSpec.describe Person do
  context "with relationships" do
    it "is able to get and set a current_spouse" do
      person1 = create(:person)
      person2 = create(:person)

      expect(person1.current_spouse_id).to be_nil
      expect(person2.current_spouse_id).to be_nil
      expect(person1.current_spouse).to be_nil
      expect(person2.current_spouse).to be_nil

      person1.current_spouse = person2
      expect(person1.current_spouse_id).to eq(person2.id)
      person1.current_spouse = nil
      expect(person1.current_spouse).to be_nil

      person2.current_spouse_id = person1.id
      expect(person2.current_spouse).to eq(person1)
    end

    it "is able to get and set a mother" do
      person = create(:person)
      mother = create(:person)

      expect(person.mother_id).to be_nil
      expect(person.mother).to be_nil

      person.mother = mother
      expect(person.mother_id).to eq(mother.id)

      person.mother = nil
      expect(person.mother_id).to be_nil

      person.mother_id = mother.id
      expect(person.mother).to eq(mother)
    end

    it "is able to get and set a father" do
      person = create(:person)
      father = create(:person)

      expect(person.father_id).to be_nil
      expect(person.father).to be_nil

      person.father = father
      expect(person.father_id).to eq(father.id)

      person.father = nil
      expect(person.father_id).to be_nil

      person.father_id = father.id
      expect(person.father).to eq(father)
    end

    it "recognizes children" do
      mother = create(:person)
      father = create(:person)
      child = create(:person)

      child.mother = mother
      child.save_without_history!

      expect(mother.children).to include child

      child.mother = nil
      child.father = father
      child.save_without_history!

      expect(father.children).to include child
    end

    it "recognizes siblings" do
      parent = create(:person)
      child1 = create(:person)
      child2 = create(:person)

      child1.mother = parent
      child1.save_without_history!
      child2.mother = parent
      child2.save_without_history!

      expect(child1.siblings).to include child2
      expect(child2.siblings).to include child1
    end
  end

  context "with a name" do
    it "properly formats a full name" do
      person = build(:person)
      expect(person.full_name).to eq("#{person.first_name} #{person.last_name}")
    end

    it "properly formats a title" do
      person = create_person(create(:fact, fact_type: "birth"), create(:fact, fact_type: "death"))
      expect(person.title).to start_with person.full_name
      expect(person.title).to end_with person.lifespan
    end
  end

  context "with attached dates" do
    it "determines a very old person with no death date as dead" do
      person = create_person(create(:fact, fact_type: "birth", date_string: "1900-01-01"))
      expect(person.probably_alive?).to be false
      expect(person.probably_dead?).to be true
    end

    it "with a death date is dead" do
      person = create_person(create(:fact, fact_type: "death"))
      expect(person.probably_alive?).to be false
      expect(person.probably_dead?).to be true
    end

    it "with no death date is assumed dead" do
      person = create(:person)
      expect(person.probably_alive?).to be false
      expect(person.probably_dead?).to be true
    end

    it "calculates lifespan correctly for no dates" do
      known_neither = build(:person)
      expect(known_neither.lifespan).to eq("")
    end

    it "calculates lifespan correctly for birthdate only" do
      known_birth = create_person(create(:fact, fact_type: "birth", date_string: "1900-01-01"))
      expect(known_birth.lifespan).to end_with "?)"
    end

    it "calculates lifespan correctly for deathdate only" do
      known_death = create_person(create(:fact, fact_type: "death"))
      expect(known_death.lifespan).to start_with "(?"
    end

    it "calculates lifespan correctly for alive person" do
      alive = create_person(create(:fact, fact_type: "birth", date_string: Time.zone.today))
      expect(alive.probably_alive?).to be true
      expect(alive.lifespan).to end_with "Present)"
    end

    it "calculates lifespan correctly for known birth and death" do
      known_both = create_person(create(:fact, fact_type: "birth"), create(:fact, fact_type: "death"))
      expect(known_both.lifespan).to match(/\([0-9]{4} - [0-9]{4}\)/)
    end
  end
end
