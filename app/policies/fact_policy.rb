# frozen_string_literal: true

class FactPolicy < ApplicationPolicy
  def show?
    return true if admin?

    # TODO: Will need to be updated if there's more than one Factable
    PersonPolicy.new(user, record.factable).show?
  end
end
