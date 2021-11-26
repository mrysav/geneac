# frozen_string_literal: true

require 'byebug'
require_relative '../../config/environment'

module TextAnalysis
  # Analyzes a block of user-entered text for possible
  # name matches in the database.
  class NameAnalyer
    POSSIBLE_NAMES_EN = /([A-Z]\w+\s?){2,3}/.freeze

    def self.analyze_names(text)
      # byebug
      ActiveRecord::Base.logger = nil

      matches = []
      pos = 0
      while pos < text.length
        match = POSSIBLE_NAMES_EN.match(text, pos)
        break unless match

        matches << {
          text: match[0].strip,
          offset: match.offset(0)
        }
        pos = match.offset(0)[1]
      end

      matches.each do |match|
        # puts match
        person_matches = Person.search_by_full_name(match[:text])
        if person_matches.any?
          puts person_matches[0].title
          puts person_matches[0].url_path
        end
      end


      DidYouMean::Levenshtein.distance("dog", "cat")
    end
  end
end

puts TextAnalysis::NameAnalyer.analyze_names(File.read('sampletext.md'))
