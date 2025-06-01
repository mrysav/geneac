# frozen_string_literal: true

require "rails_helper"
require "person_spec_helper"

RSpec.describe "People" do
  let(:dead) do
    create_person(create(:fact, fact_type: "birth", date_string: "1900"),
                  create(:fact, fact_type: "death", date_string: "1980"))
  end

  let(:alive) do
    person = create_person(create(:fact, fact_type: "birth", date_string: (Time.zone.today - 90.days).to_s))
    # Create a relationship so policy_scope on @children will work
    person.mother = dead
    person.save_without_history!
    person
  end

  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }

  before do
    Setting.restrict_living_info = false
    Setting.require_login = false
  end

  context 'with "require login" set' do
    before do
      Setting.require_login = true
    end

    it "hides everything from anonymous users" do
      get "/p/#{dead.friendly_url}"
      expect(response).to have_http_status(:forbidden)
      get "/p/#{alive.friendly_url}"
      expect(response).to have_http_status(:forbidden)
    end

    it "shows everything to admins" do
      sign_in admin
      get "/p/#{dead.friendly_url}"
      expect(response).to have_http_status(:success)
      get "/p/#{alive.friendly_url}"
      expect(response).to have_http_status(:success)
    end

    it "shows everything to users" do
      sign_in user
      get "/p/#{dead.friendly_url}"
      expect(response).to have_http_status(:success)
      get "/p/#{alive.friendly_url}"
      expect(response).to have_http_status(:success)
    end
  end

  context 'with "restrict living info" set' do
    before do
      Setting.restrict_living_info = true
    end

    it "shows everything to admins" do
      sign_in admin
      get "/p/#{alive.friendly_url}/family"
      expect(response).to have_http_status(:success)
      get "/p/#{dead.friendly_url}/family"
      expect(response).to have_http_status(:success)
      expect(assigns(:children)).to include(alive)
    end

    it "shows only dead to users" do
      sign_in user
      get "/p/#{alive.friendly_url}/family"
      expect(response).to have_http_status(:forbidden)
      get "/p/#{dead.friendly_url}/family"
      expect(response).to have_http_status(:success)
      expect(assigns(:children)).not_to include(alive)
    end

    it "shows only dead to anonymous users" do
      get "/p/#{alive.friendly_url}/family"
      expect(response).to have_http_status(:forbidden)
      get "/p/#{dead.friendly_url}/family"
      expect(response).to have_http_status(:success)
      expect(assigns(:children)).not_to include(alive)
    end
  end
end
