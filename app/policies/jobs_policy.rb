# Policy for the jobs panel
# You can only see jobs as an admin.
class JobsPolicy < ApplicationPolicy
  def view?
    admin?
  end
end
