# Monkey patch to make the … page work again
# The breaking change was https://github.com/thoughtbot/administrate/commit/dc856a917aa67e998860bb42664b5da94eb0e682#diff-a4a632998186059ef606368d710ac173
# Issue is open at https://github.com/thoughtbot/administrate/issues/1570
raise "Try to remove this monkey patch when updating Administrate" if Gem.loaded_specs["administrate"].version != Gem::Version.new("0.13.0")

module Administrate
  module Page
    class Base
      protected

      def get_attribute_value(resource, attribute_name)
        resource.public_send(attribute_name)
      rescue NameError
        nil
      end
    end
  end
end
