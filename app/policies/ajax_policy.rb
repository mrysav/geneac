# frozen_string_literal: true

# Controls access to AJAX actions in AjaxController.
class AjaxPolicy < ApplicationPolicy
  def tags?
    admin?
  end

  def people_tags?
    admin?
  end

  def people_tag?
    admin?
  end

  private

  def admin?
    !user.nil? && user.admin?
  end
end
