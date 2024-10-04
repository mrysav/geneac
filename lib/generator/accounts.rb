# frozen_string_literal: true

module Generator
  # Defines a method that can be used in rake tasks to generate user accounts.
  module Accounts
    def self.create_account(name, email, password, admin: false)
      if User.where(email:).count.positive?
        Rails.logger.info "Account #{email} already exists."
        return
      end

      Rails.logger.info "Creating account #{email} with password #{password}"

      User.create!(name:, email:,
                   password:, password_confirmation: password,
                   admin:)
    end
  end
end
