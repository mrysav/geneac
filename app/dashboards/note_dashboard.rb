require "administrate/base_dashboard"

class NoteDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    title: Field::String,
    date_string: AdvancedDateField,
    rich_content: RichTextAreaField,
    tag_list: TagListField,
    tagged_person_list: PersonTagListField,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    citation: Field::HasOne
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    title
    tag_list
    date_string
    updated_at
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    title
    date_string
    rich_content
    citation
    tag_list
    tagged_person_list
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    title
    date_string
    rich_content
    citation
    tag_list
    tagged_person_list
  ].freeze

  # Overwrite this method to customize how notes are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(note)
    note.title || "Note ##{note.id}"
  end
end
