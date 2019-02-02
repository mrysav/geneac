# frozen_string_literal: true

require 'test_helper'

module Ajax
  class AjaxControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    test 'ajax tags' do
      sign_in users(:doc)
      get ajax_tags_path
      assert_response :success
    end

    test 'ajax people' do
      sign_in users(:doc)
      get ajax_people_tags_path
      assert_response :success
    end

    test 'ajax person' do
      sign_in users(:doc)
      chandler = people(:chandler)
      get ajax_people_tag_path(chandler.id)
      assert_response :success
    end

    test 'non-admin unauthorized' do
      sign_in users(:biff)
      get ajax_tags_path
      assert_response :unauthorized
      get ajax_people_tags_path
      assert_response :unauthorized
      get ajax_people_tag_path(people(:chandler).id)
      assert_response :unauthorized
    end
  end
end
