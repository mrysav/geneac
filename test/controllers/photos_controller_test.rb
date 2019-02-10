# frozen_string_literal: true

require 'test_helper'

class PhotosControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @photo = Photo.new
    @photo.title = 'Hello world'
    file = File.open Rails.root.join('test', 'fixtures', 'files', 'image.jpg')
    @photo.image.attach(io: file, filename: 'image.jpg')
    @photo.save!
  end

   test 'anonymous user visibility' do
    Setting.require_login = false
    Setting.restrict_living_info = false
    get photo_path @photo.id
    assert_response :success

    Setting.require_login = false
    Setting.restrict_living_info = true
    @photo.tagged_person_list = ['1']
    @photo.save!
    get photo_path @photo.id
    assert_response :forbidden

    Setting.require_login = false
    Setting.restrict_living_info = true
    @photo.tagged_person_list = []
    @photo.save!
    get photo_path @photo.id
    assert_response :success

    Setting.require_login = true
    Setting.restrict_living_info = false
    get photo_path @photo.id
    assert_response :forbidden

    Setting.require_login = true
    Setting.restrict_living_info = true
    get photo_path @photo.id
    assert_response :forbidden
  end

   test 'non-admin user visibility' do
    sign_in users(:biff)

    Setting.require_login = false
    Setting.restrict_living_info = false
    get photo_path @photo.id
    assert_response :success

    Setting.require_login = false
    Setting.restrict_living_info = true
    @photo.tagged_person_list = ['1']
    @photo.save!
    get photo_path @photo.id
    assert_response :forbidden

    Setting.require_login = false
    Setting.restrict_living_info = true
    @photo.tagged_person_list = []
    @photo.save!
    get photo_path @photo.id
    assert_response :success

    Setting.require_login = true
    Setting.restrict_living_info = false
    get photo_path @photo.id
    assert_response :success

    Setting.require_login = true
    Setting.restrict_living_info = true
    @photo.tagged_person_list = ['1']
    @photo.save!
    get photo_path @photo.id
    assert_response :forbidden

    Setting.require_login = true
    Setting.restrict_living_info = true
    @photo.tagged_person_list = []
    @photo.save!
    get photo_path @photo.id
    assert_response :success
  end

   test 'admin user visibility' do
    sign_in users(:doc)

    Setting.require_login = false
    Setting.restrict_living_info = false
    get photo_path @photo.id
    assert_response :success

    Setting.require_login = false
    Setting.restrict_living_info = true
    @photo.tagged_person_list = ['1']
    @photo.save!
    get photo_path @photo.id
    assert_response :success

    Setting.require_login = false
    Setting.restrict_living_info = true
    @photo.tagged_person_list = []
    @photo.save!
    get photo_path @photo.id
    assert_response :success

    Setting.require_login = true
    Setting.restrict_living_info = false
    get photo_path @photo.id
    assert_response :success

    Setting.require_login = true
    Setting.restrict_living_info = true
    @photo.tagged_person_list = ['1']
    @photo.save!
    get photo_path @photo.id
    assert_response :success

    Setting.require_login = true
    Setting.restrict_living_info = true
    @photo.tagged_person_list = []
    @photo.save!
    get photo_path @photo.id
    assert_response :success
  end
end
