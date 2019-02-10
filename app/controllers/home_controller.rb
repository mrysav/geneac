# frozen_string_literal: true

# Controller for any 'home' actions
class HomeController < ApplicationController
  def index
    if Setting.show_recent_updates
      @recent_updates = recent_updates
    else
      skip_authorization
    end
  end

  private

  def recent_updates
    updates = []
    Person.order('updated_at desc').limit(5)
          .each { |p| updates.push(p) }
    Photo.order('updated_at desc').limit(5)
         .each { |p| updates.push(p) }
    Note.order('updated_at desc').limit(5)
        .each { |n| updates.push(n) }

    updates.sort_by!(&:updated_at).reverse!
    updates = updates[0..4]
    authorize_list updates
    updates
  end

end
