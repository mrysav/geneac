# frozen_string_literal: true

require 'test_helper'

class NotesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

   test 'anonymous user visibility' do
    note = notes(:markdown)

    Setting.require_login = false
    Setting.restrict_living_info = false
    get note_path note.id
    assert_response :success

    Setting.require_login = false
    Setting.restrict_living_info = true
    note.tagged_person_list = ['1']
    note.save!
    get note_path note.id
    assert_response :forbidden

    Setting.require_login = false
    Setting.restrict_living_info = true
    note.tagged_person_list = []
    note.save!
    get note_path note.id
    assert_response :success

    Setting.require_login = true
    Setting.restrict_living_info = false
    get note_path note.id
    assert_response :forbidden

    Setting.require_login = true
    Setting.restrict_living_info = true
    get note_path note.id
    assert_response :forbidden
  end

   test 'non-admin user visibility' do
    note = notes(:markdown)
    sign_in users(:biff)

    Setting.require_login = false
    Setting.restrict_living_info = false
    get note_path note.id
    assert_response :success

    Setting.require_login = false
    Setting.restrict_living_info = true
    note.tagged_person_list = ['1']
    note.save!
    get note_path note.id
    assert_response :forbidden

    Setting.require_login = false
    Setting.restrict_living_info = true
    note.tagged_person_list = []
    note.save!
    get note_path note.id
    assert_response :success

    Setting.require_login = true
    Setting.restrict_living_info = false
    get note_path note.id
    assert_response :success

    Setting.require_login = true
    Setting.restrict_living_info = true
    note.tagged_person_list = ['1']
    note.save!
    get note_path note.id
    assert_response :forbidden

    Setting.require_login = true
    Setting.restrict_living_info = true
    note.tagged_person_list = []
    note.save!
    get note_path note.id
    assert_response :success
  end

   test 'admin user visibility' do
    note = notes(:markdown)
    sign_in users(:doc)

    Setting.require_login = false
    Setting.restrict_living_info = false
    get note_path note.id
    assert_response :success

    Setting.require_login = false
    Setting.restrict_living_info = true
    note.tagged_person_list = ['1']
    note.save!
    get note_path note.id
    assert_response :success

    Setting.require_login = false
    Setting.restrict_living_info = true
    note.tagged_person_list = []
    note.save!
    get note_path note.id
    assert_response :success

    Setting.require_login = true
    Setting.restrict_living_info = false
    get note_path note.id
    assert_response :success

    Setting.require_login = true
    Setting.restrict_living_info = true
    note.tagged_person_list = ['1']
    note.save!
    get note_path note.id
    assert_response :success

    Setting.require_login = true
    Setting.restrict_living_info = true
    note.tagged_person_list = []
    note.save!
    get note_path note.id
    assert_response :success
  end
end
