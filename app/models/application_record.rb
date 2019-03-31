# frozen_string_literal: true

require 'chronic'

# Parent class of all ActiveRecord objects
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
