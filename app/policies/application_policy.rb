# frozen_string_literal: true

# Default access settings for all models
class ApplicationPolicy
  # Default access settings for groups of objects
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end

    def admin?
      logged_in? && user.admin?
    end

    def logged_in?
      !user.nil?
    end
  end

  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    admin?
  end

  def show?
    scope.exists?(id: record.id)
  end

  def create?
    admin?
  end

  def new?
    create?
  end

  def update?
    admin?
  end

  def edit?
    update?
  end

  def destroy?
    admin?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  protected

  def admin?
    logged_in? && user.admin?
  end

  def logged_in?
    !user.nil?
  end
end
