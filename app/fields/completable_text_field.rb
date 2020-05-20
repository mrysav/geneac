# frozen_string_literal: true

require 'administrate/field/base'

class CompletableTextField < Administrate::Field::Base
  def suggestion_url
    options[:suggestion_url]
  end

  def to_s
    data
  end
end
