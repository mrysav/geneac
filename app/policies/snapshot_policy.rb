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

  def restore?
    admin?
  end

  def initiate?
    admin?
  end
end
