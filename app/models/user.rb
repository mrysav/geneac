# frozen_string_literal: true

require 'digest/md5'

# User record
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def profile_image(size = 100)
    # get gravatar image URL
    hash = Digest::MD5.hexdigest(email.downcase)
    "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
  end

  def add_edit_history(editable:, action:, date:)
    self.edit_history = [] unless edit_history

    edit_history.append({
                          action: action,
                          editable_type: editable.class.name.underscore,
                          editable_id: editable.id,
                          date: date
                        })
  end

  def recent_edits
    return [] unless edit_history

    edit_history.map do |e|
      {
        editable: e['editable_type'].camelize.constantize.find(e['editable_id']),
        action: e['action'],
        date: ActiveSupport::TimeZone['UTC'].parse(e['date'])
      }
    end
  end
end
