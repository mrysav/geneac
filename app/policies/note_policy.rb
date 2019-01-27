# frozen_string_literal: true

class NotePolicy < ApplicationPolicy
  def show?
    # TODO: deeper dive in permissions here
    user&.admin? || record.tagged_person_list.empty?
  end
end
