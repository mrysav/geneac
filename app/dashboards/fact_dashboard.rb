require "administrate/base_dashboard"

class FactDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    factable: Field::Polymorphic,
    id: Field::Number,
    fact_type: Field::String,
    date_string: AdvancedDateField,
    place: Field::String,
    description: Field::Text,
    tagged_person_list: PersonTagListField,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    citations: Field::NestedHasMany.with_options(skip: :citable)
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    fact_type
    factable
    date_string
    place
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    factable
    fact_type
    date_string
    place
    description
    tagged_person_list
    citations
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    fact_type
    date_string
    place
    description
    tagged_person_list
    citations
  ].freeze

  # Overwrite this method to customize how facts are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(fact)
  #   "Fact ##{fact.id}"
  # end
end
