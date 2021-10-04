# frozen_string_literal: true

# Model to create SQL functions for common use
module SqlFunctions
  extend ActiveSupport::Concern

  class_methods do
    def add_valid_date_function
      is_valid_date_function = <<-SQL.squish
        create or replace function is_valid_date(str varchar)
        returns boolean
        language plpgsql as $$
        begin
          perform str::date;
          return true;
        exception when others then
          return false;
        end;
        $$;
      SQL
      ActiveRecord::Base.connection.execute(is_valid_date_function)
    end
  end
end
