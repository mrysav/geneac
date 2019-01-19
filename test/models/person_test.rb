# frozen_string_literal: true

require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  test 'current spouse' do
    spouse = people(:chandler).current_spouse
    assert_equal people(:monica).id, spouse.id
  end

  test 'full name' do
    assert_equal 'Chandler Bing', people(:chandler).full_name
    assert_equal 'Jack', people(:jack).full_name
  end

  test 'lifespan' do
    assert_equal '(? - 1980)', people(:grandma).lifespan
    assert_equal '(1910 - 1970)', people(:great_grandpa).lifespan
    assert_equal '(1910 - ?)', people(:great_grandma).lifespan
    assert_equal '(1975 - Present)', people(:chandler).lifespan
    assert_equal '', people(:ross).lifespan
  end

  test 'siblings' do
    assert_equal 1, people(:monica).siblings.count
    assert_equal people(:ross).id, people(:monica).siblings[0].id
  end

  test 'children' do
    assert_equal 1, people(:monica).children.count
    assert_equal 1, people(:chandler).children.count
    assert_equal people(:jack).id, people(:monica).children[0].id
    assert_equal people(:jack).id, people(:chandler).children[0].id
  end

  test 'probably dead or alive' do
    assert people(:monica).probably_alive?
    assert people(:ross).probably_dead?
    assert people(:great_grandma).probably_dead?
    assert people(:great_grandpa).probably_dead?
  end

  test 'title' do
    assert_equal 'Monica Geller (1976 - Present)', people(:monica).title
    assert_equal 'Ross Geller', people(:ross).title
  end

  test 'edtf birth date' do
    ross = people(:ross)
    assert_nil ross.date_of_birth
    ross.date_of_birth = '2010-10-31'
    assert_equal 2010, ross.date_of_birth.year
    ross.date_of_birth = '10/31/2010'
    assert_nil ross.date_of_birth
  end

  test 'edtf death date' do
    ross = people(:ross)
    assert_nil ross.date_of_death
    ross.date_of_death = '2010-10-31'
    assert_equal 2010, ross.date_of_death.year
    ross.date_of_death = '10/31/2010'
    assert_nil ross.date_of_death
  end
end
