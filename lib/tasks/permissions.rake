# frozen_string_literal: true

namespace :admin do
  desc "Grant admin permissions"
  task :grant, [:user] => :environment do |_task, args|
    set_admin(args.user, true)
  end

  desc "Revoke admin permissions"
  task :revoke, [:user] => :environment do |_task, args|
    set_admin(args.user, false)
  end

  def set_admin(email, is_admin)
    user = User.find_by(email:)
    user.admin = is_admin
    user.save!
    puts "#{email} is admin: #{is_admin}"
  rescue StandardError => e
    puts e
  end
end
