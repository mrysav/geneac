# frozen_string_literal: true

require "rails_helper"

def create_person(*facts)
  person = create(:person)
  facts.each do |fact|
    fact.factable = person
    fact.save_without_history!
  end
  person.save_without_history!
  person
end
