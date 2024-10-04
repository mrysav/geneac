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
    sex: Field::String,
    bio: Field::Text,
    birth_date: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    father_id: PersonField,
    mother_id: PersonField,
    current_spouse_id: PersonField,
    children: Field::HasMany.with_options(
      class_name: "Person"
    ),
    facts: Field::NestedHasMany.with_options(skip: :factable)
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    first_name
    last_name
    birth_date
    updated_at
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    first_name
    last_name
    alternate_names
    gender
    sex
    bio
    created_at
    updated_at
    father_id
    mother_id
    current_spouse_id
    children
    facts
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    first_name
    last_name
    alternate_names
    gender
    sex
    bio
    father_id
    mother_id
    current_spouse_id
    facts
  ].freeze

  # Overwrite this method to customize how people are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(person)
    "#{person.first_name} #{person.last_name}"
  end
end
