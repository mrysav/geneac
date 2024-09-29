# frozen_string_literal: true

# Controller for any 'home' actions
class HomeController < ApplicationController
  RECENT_BIRTHDAYS_LIMIT = 5
  RECENT_BIRTHDAYS_RANGE = 1.month

  def index
    @recent_updates = recent_updates if Setting.show_recent_updates
    @recent_birthdays = recent_birthdays if Setting.show_recent_birthdays

    skip_authorization if @recent_updates.nil? && @recent_birthdays.nil?
  end

  private

  def recent_updates
    skip_authorization

    updates = []
    Person.order("updated_at desc").limit(5)
          .each { |p| updates.push(p) }
    Photo.order("updated_at desc").limit(5)
         .each { |p| updates.push(p) }
    Note.order("updated_at desc").limit(5)
        .each { |n| updates.push(n) }

    updates.sort_by!(&:updated_at).reverse!
    updates = updates[0..4]
    authorize_list updates
    updates
  end

  def recent_birthdays
    skip_authorization

    birthdays = Fact.birthdays_in_range(
      Time.zone.today, Time.zone.today + RECENT_BIRTHDAYS_RANGE, RECENT_BIRTHDAYS_LIMIT
    )
    authorize_list birthdays.to_a
    birthdays
  end
end
