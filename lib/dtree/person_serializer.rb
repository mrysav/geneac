# frozen_string_literal: true

module DTree
  # Methods that will serialize a person for use with DTree
  module Person
    include Pundit::Authorization

    def serialize_person(person)
      returned = []
      returned << {
        name: person.full_name,
        class: 'node',
        textClass: 'nodeText',
        depthOffset: 1,
        marriages: []
      }

      current_spouse = person.current_spouse
      children = policy_scope(person.children)
      siblings = policy_scope(person.siblings)

      returned
    end
  end
end
