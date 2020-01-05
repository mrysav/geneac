# frozen_string_literal: true

namespace :content do
  desc 'Drop all content'
  task drop: :environment do
    [Person, Note, Photo, Fact].each do |model_type|
      model_type.drop_em_all!
      puts "Dropped all: #{model_type}"
    end
  end
end
