# frozen_string_literal: true

require 'generator/accounts'

namespace :generate do
  desc 'Generate test accounts'
  task 'test-accounts': :environment do
    Generator::Accounts.create_account 'Marty McFly', 'mcfly@bttf.net', 'thatsheavy', admin: true
    Generator::Accounts.create_account 'Lorraine McFly', 'lorraine@bttf.net', 'calvink', admin: false
  end
end
