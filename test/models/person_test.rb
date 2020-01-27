# frozen_string_literal: true

require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  test 'current spouse' do
    spouse = people(:monica).current_spouse
    assert_equal people(:chandler).id, spouse.id
    spouse.current_spouse = people(:ross)
    assert_equal people(:ross).id, spouse.current_spouse.id
  end

  test 'mother' do
    child = people(:chandler)
    child.mother = people(:grandma)
    assert_equal people(:grandma).id, child.mother.id
  end

  test 'father' do
    child = people(:jack)
    child.father = people(:ross)
    assert_equal people(:ross).id, child.father.id
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

  test 'parse birth date' do
    ross = people(:ross)
    assert_nil ross.birth_date_string
    ross.birth_date_string = '2010-10-31'
    assert_equal 2010, ross.birth_date.year
    ross.birth_date_string = '10/31/2010'
    assert_equal 2010, ross.birth_date.year
  end

  test 'parse death date' do
    ross = people(:ross)
    assert_nil ross.death_date
    ross.death_date_string = '2010-10-31'
    assert_equal 2010, ross.death_date.year
    ross.death_date_string = '10/31/2010'
    assert_equal 2010, ross.death_date.year
  end

  test 'parse birth date year only' do
    joey = Person.new
    joey.birth_date_string = '1980'
    assert_equal 1980, joey.birth_date.year
  end
end
