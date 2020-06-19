# frozen_string_literal: true

require 'chronic'

# Module for custom date-parsing logic
module ParseableDate
  extend ActiveSupport::Concern

  def parse(date)
    @parsers ||= [
      ParseableDate.method(:parse_four_digit_year),
      Chronic.method(:parse)
    ]

    parsed_date = nil

    @parsers.each do |parser|
      parsed_date = parser.call(date)
      break unless parsed_date.nil?
    end

    parsed_date
  end

  # @todo In the event I need to parse years < 1000 or > 9999... fix this
  def self.parse_four_digit_year(date)
    Date.new(date.to_i) if !date.nil? && date.match(/^[1-9][0-9]{3}$/)
  end
end
