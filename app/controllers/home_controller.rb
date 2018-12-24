# frozen_string_literal: true

# Controller for any 'home' actions
class HomeController < ApplicationController
  def index
    # @recent_photos = Photo.order('updated_at desc').limit(3)
    @recent_updates = []
    Person.order('updated_at desc').limit(5).each do |p|
      @recent_updates.push(
        title: p.full_name,
        updated_at: p.updated_at,
        model: p
      )
    end
    Note.order('updated_at desc').limit(5).each do |n|
      @recent_updates.push(
        title: n.title,
        updated_at: n.updated_at,
        model: n
      )
    end
    Photo.order('updated_at desc').limit(5).each do |p|
      @recent_updates.push(
        title: p.title,
        updated_at: p.updated_at,
        model: p
      )
    end
    @recent_updates.sort_by! { |r| r[:updated_at] }.reverse!
  end
end
