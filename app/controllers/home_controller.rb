# frozen_string_literal: true

# Controller for any 'home' actions
class HomeController < ApplicationController
  def index
    @recent_updates = []
    Person.order('updated_at desc').limit(5)
          .each { |p| @recent_updates.push(p) }
    Note.order('updated_at desc').limit(5)
        .each { |n| @recent_updates.push(n) }
    Photo.order('updated_at desc').limit(5)
         .each { |p| @recent_updates.push(p) }

    @recent_updates.sort_by!(&:updated_at).reverse!
    @recent_updates = @recent_updates[0..4]
  end
end
