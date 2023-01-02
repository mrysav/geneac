# frozen_string_literal: true

module DTree
  # Methods that will serialize a person for use with DTree
  module Person
    include Pundit::Authorization

    def serialize_person(person)
      returned = []

      # Assume that `person` has already been authorized if the function has been called.
      # We will start with the mother as the root if there is one.
      # If not, then we will start with the father.
      # If neither is present, we'll start with the person themselves.

      root = person.mother
      root ||= person.father
      root ||= person

      marriages = {}
      unknown_spouse = {
        spouse: {
          name: 'Unknown',
          textClass: 'nodeText'
        },
        children: []
      }

      # todo need to authorize siblings

      policy_scope(root.children).each do |child|
        opposite_spouse = if child.father_id == root.id
                            child.mother
                          elsif child.mother_id == root.id
                            child.father
                          end

        marriage = nil

        unless opposite_spouse
          marriages[-1] ||= unknown_spouse
          marriage = marriages[-1]
        end

        if !marriage && !marriages[opposite_spouse.id]
          marriages[opposite_spouse.id] = {
            spouse: {
              name: opposite_spouse.full_name,
              textClass: 'nodeText'
            },
            children: []
          }
        end

        marriage ||= marriages[opposite_spouse.id]

        marriage[:children] << {
          name: child.full_name,
          textClass: 'nodeText'
        }
      end

      [{
        name: root.full_name,
        class: 'node',
        textClass: 'nodeText',
        marriages: marriages.values
      }]
    end
  end
end
