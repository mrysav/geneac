class SnapshotPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def edit?
    false
  end

  def show?
    admin?
  end
end
