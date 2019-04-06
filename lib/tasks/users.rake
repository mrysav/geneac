# frozen_string_literal: true

namespace :users do
  desc 'Create user'
  task :create, %i[email password confirmation] => :environment do |_task, args|
    user = User.new(email: args.email, password: args.password,
                    password_confirmation: args.confirmation)
    user.save!
    puts "Created user #{user.email}"
  end
end
