# frozen_string_literal: true

namespace :content do
  desc 'Drop all content'
  task drop: :environment do
    Person.all.each(&:destroy!)
    ActiveRecord::Base.connection.reset_pk_sequence!(Person.table_name)
    puts 'Dropped all People'

    Note.all.each(&:destroy!)
    ActiveRecord::Base.connection.reset_pk_sequence!(Note.table_name)
    puts 'Dropped all Notes'

    Photo.all.each(&:destroy!)
    ActiveRecord::Base.connection.reset_pk_sequence!(Photo.table_name)
    puts 'Dropped all Photos'

    Fact.all.each(&:destroy!)
    ActiveRecord::Base.connection.reset_pk_sequence!(Fact.table_name)
    puts 'Dropped all Facts'
  end
end
