# frozen_string_literal: true

require 'test_helper'

class PeopleControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

   test 'anonymous user visibility' do
    alive = people(:chandler)
    dead = people(:great_grandpa)

    Setting.require_login = false
    Setting.restrict_living_info = false
    get person_path dead.id
    assert_response :success

    Setting.require_login = false
    Setting.restrict_living_info = true
    get person_path alive.id
    assert_response :forbidden

    Setting.require_login = false
    Setting.restrict_living_info = true
    get person_path dead.id
    assert_response :success

    Setting.require_login = true
    Setting.restrict_living_info = false
    get person_path dead.id
    assert_response :forbidden

    Setting.require_login = true
    Setting.restrict_living_info = true
    get person_path dead.id
    assert_response :forbidden
  end

   test 'non-admin user visibility' do
    alive = people(:chandler)
    dead = people(:great_grandpa)
    sign_in users(:biff)

    Setting.require_login = false
    Setting.restrict_living_info = false
    get person_path dead.id
    assert_response :success

    Setting.require_login = false
    Setting.restrict_living_info = true
    get person_path alive.id
    assert_response :forbidden

    Setting.require_login = false
    Setting.restrict_living_info = true
    get person_path dead.id
    assert_response :success

    Setting.require_login = true
    Setting.restrict_living_info = false
    get person_path dead.id
    assert_response :success

    Setting.require_login = true
    Setting.restrict_living_info = true
    get person_path alive.id
    assert_response :forbidden

    Setting.require_login = true
    Setting.restrict_living_info = true
    get person_path dead.id
    assert_response :success
  end

   test 'admin user visibility' do
    alive = people(:chandler)
    dead = people(:great_grandpa)
    sign_in users(:doc)

    Setting.require_login = false
    Setting.restrict_living_info = false
    get person_path dead.id
    assert_response :success

    Setting.require_login = false
    Setting.restrict_living_info = true
    get person_path alive.id
    assert_response :success

    Setting.require_login = false
    Setting.restrict_living_info = true
    get person_path dead.id
    assert_response :success

    Setting.require_login = true
    Setting.restrict_living_info = false
    get person_path dead.id
    assert_response :success

    Setting.require_login = true
    Setting.restrict_living_info = true
    get person_path alive.id
    assert_response :success

    Setting.require_login = true
    Setting.restrict_living_info = true
    get person_path dead.id
    assert_response :success
  end
end
