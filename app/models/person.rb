# frozen_string_literal: true

# Model for people
class Person < ApplicationRecord
  include ParseableDate
  include FriendlyUrlName
  include RecordHistory

  has_many :facts, as: :factable, dependent: :destroy
  accepts_nested_attributes_for :facts

  belongs_to :mother, class_name: 'Person', optional: true
  has_many :mothered_children, class_name: 'Person', dependent: :nullify, foreign_key: 'mother_id', inverse_of: :mother

  belongs_to :father, class_name: 'Person', optional: true
  has_many :fathered_children, class_name: 'Person', dependent: :nullify, foreign_key: 'father_id', inverse_of: :father

  belongs_to :current_spouse, class_name: 'Person', optional: true

  belongs_to :profile_photo, class_name: 'Photo', optional: true

  include PgSearch::Model
  multisearchable against: %i[first_name last_name alternate_names]

  before_save :update_special_fact_types
  before_save :update_probably_alive
  before_save :update_profile_photo
  before_destroy :update_current_spouse

  has_friendly_url_name field: :friendly_url, field_name: :full_name, url_root: 'p'

  # title is used when this shows up in search results
  def title
    [full_name, lifespan].reject(&:empty?).join(' ')
  end

  def children
    mothered_children.or(fathered_children)
  end

  def siblings
    Person.where('id != ? AND ((father_id > 0 AND father_id = ?)'\
                 ' OR (mother_id > 0 AND mother_id = ?))',
                 id, father_id, mother_id)
  end

  def birth_date
    Fact.find(birth_fact_id).date if birth_fact_id
  end

  def death_date
    Fact.find(death_fact_id).date if death_fact_id
  end

  def full_name
    [first_name || '', last_name || ''].reject(&:empty?).join(' ')
  end

  def lifespan
    birth_year = birth_date&.year
    death_year = death_date&.year
    return '' unless birth_year || death_year

    birth = birth_year || '?'
    death = death_year || (probably_dead? ? '?' : 'Present')
    "(#{birth} - #{death})"
  end

  def probably_dead?
    !probably_alive?
  end

  private

  # @todo More sophisticated probably_alive logic
  # Obviously a person can live to be older than 90,
  # but the US census releases records after 70 years
  # so I figure I'm good here
  # Also, what do we do about records that have no birth or death date,
  # but obviously lived and died > 90 years ago?
  def update_probably_alive
    definitely_dead = !death_date.nil?
    age = Time.zone.today.year - (birth_date&.year || 0)
    self.probably_alive = !definitely_dead && age < 90
  end

  # Called before_destroy to ensure the spouse's record does not go stale.
  def update_current_spouse
    return unless current_spouse

    current_spouse.current_spouse = nil
    current_spouse.save!
  end

  # Updates the index of the fact that represents the birth, death, burial, etc.
  # This index is used to speed up lookups of these dates for rendering.
  # Uses first fact of the desired type that it finds
  def update_special_fact_types
    {
      birth_fact_id: 'birth',
      death_fact_id: 'death'
    }.each do |fact, fact_type|
      self[fact] = facts.where(fact_type: fact_type).limit(1)[0]&.id
    end
  end

  def update_profile_photo
    return if profile_photo_id

    photos = Photo.tagged_with(id.to_s)
    self.profile_photo_id = photos[0].id if photos.size.positive?
  end
end
