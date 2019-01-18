# frozen_string_literal: true

require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  test 'current spouse' do
    spouse = people(:chandler).current_spouse
    assert spouse.id == people(:monica).id
  end

  test 'full name' do
    assert people(:chandler).full_name == 'Chandler Bing'
    assert people(:jack).full_name == 'Jack'
  end

  test 'lifespan' do
    assert people(:grandma).lifespan == '(? - 1980)'
    assert people(:great_grandpa).lifespan == '(1910 - 1970)'
    assert people(:great_grandma).lifespan == '(1910 - ?)'
    assert people(:chandler).lifespan == '(1975 - Present)'
    assert people(:ross).lifespan == ''
  end

  test 'siblings' do
    assert people(:monica).siblings.count == 1
    assert people(:monica).siblings[0].id == people(:ross).id
  end

  test 'children' do
    assert people(:monica).children.count == 1
    assert people(:chandler).children.count == 1
    assert people(:monica).children[0].id == people(:jack).id
    assert people(:chandler).children[0].id == people(:jack).id
  end

  test 'probably dead or alive' do
    assert people(:monica).probably_alive?
    assert people(:ross).probably_dead?
    assert people(:great_grandma).probably_dead?
    assert people(:great_grandpa).probably_dead?
  end

  test 'title'  do
    assert people(:monica).title == 'Monica Geller (1976 - Present)'
    assert people(:ross).title == 'Ross Geller'
  end
end
