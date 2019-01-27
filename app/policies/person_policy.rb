# frozen_string_literal: true

class PersonPolicy < ApplicationPolicy
  def show?
    user&.admin? || record.probably_dead?
  end
end
