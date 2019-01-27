# frozen_string_literal: true

class PhotoPolicy < ApplicationPolicy
  def show?
    # TODO: deeper dive into permissions here
    super && record.tagged_person_list.empty?
  end
end
