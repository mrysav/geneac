# frozen_string_literal: true

require "io/console"
require "generator/accounts"
require "generator/notes"
require "generator/people"
require "generator/photos"

namespace :generate do
  namespace :test do
    desc "Generate test accounts"
    task accounts: :environment do
      Generator::Accounts.create_account "Marty McFly", "mcfly@bttf.net", "thatsheavy", admin: true
      Generator::Accounts.create_account "Lorraine McFly", "lorraine@bttf.net", "calvink", admin: false
    end

    desc "Generate test people"
    task people: :environment do
      User.current_user = User.first
      Generator::People.create_family(count: 100, branchiness: 10)
      Rails.logger.info "Created 100 people."
    end

    desc "Generate test photos"
    task photos: :environment do
      User.current_user = User.first
      20.times do
        Generator::Photos.create_photo
      end
      Rails.logger.info "Created 20 photos."
    end

    desc "Generate test notes"
    task notes: :environment do
      User.current_user = User.first
      20.times do
        Generator::Notes.create_note
      end
      Rails.logger.info "Created 20 notes."
    end
  end

  desc "Generates test data for all models"
  task all: %i[environment test:accounts test:people test:photos test:notes] do
    Rails.logger.info "Generated test data."
  end

  desc "Resets all test data in the database"
  task reset: :environment do
    puts "We are about to drop ALL content! You will lose everything except User accounts and Snapshots!"
    puts "Press 'y' to continue. Any other key will ABORT!"
    ch = $stdin.getch
    abort("Aborted because you did not press 'y'!") unless ch == "y"

    User.current_user = User.first
    [Person, Note, Photo, Fact, Citation, EditHistory].each do |model_type|
      model_type.drop_em_all!
      puts "Dropped all: #{model_type}"
    end
  end
end
