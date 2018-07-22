require "administrate/base_dashboard"

class PersonDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    first_name: Field::String,
    last_name: Field::String,
    alternate_names: Field::String,
    gender: Field::String,
    date_of_birth: Field::String,
    date_of_death: Field::String,
    birthplace: Field::String,
    burialplace: Field::String,
    father_id: Field::Number,
    mother_id: Field::Number,
    current_spouse_id: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :first_name,
    :last_name,
    :alternate_names,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :first_name,
    :last_name,
    :alternate_names,
    :gender,
    :date_of_birth,
    :date_of_death,
    :birthplace,
    :burialplace,
    :father_id,
    :mother_id,
    :current_spouse_id,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :first_name,
    :last_name,
    :alternate_names,
    :gender,
    :date_of_birth,
    :date_of_death,
    :birthplace,
    :burialplace,
    :father_id,
    :mother_id,
    :current_spouse_id,
  ].freeze

  # Overwrite this method to customize how people are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(person)
  #   "Person ##{person.id}"
  # end
end
