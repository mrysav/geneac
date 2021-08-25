# frozen_string_literal: true

require 'open-uri'
require 'faker'

namespace :generate do
  def create_account(name, email, password, admin: false)
    if User.where(email: email).count.positive?
      Rails.logger.info "Account #{email} already exists."
      return
    end

    Rails.logger.info "Creating account #{email} with password #{password}"

    User.create!(name: name, email: email,
                 password: password, password_confirmation: password,
                 admin: admin)
  end

  desc 'Generate test accounts'
  task 'test-accounts': :environment do
    create_account 'Marty McFly', 'mcfly@bttf.net', 'thatsheavy', admin: true
    create_account 'Lorraine McFly', 'lorraine@bttf.net', 'calvink', admin: false
  end
end
