# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'People', type: :request do
  before :each do
    @dead = create(:person, :has_birthday, :has_deathday)
    @alive = create(:person, birth_date_string: (Date.today - 90.days).to_s)

    # Create a relationship so policy_scope on @children will work
    @alive.mother = @dead
    @alive.save!

    @user = create(:user)
    @admin = create(:user, :admin)

    Setting.restrict_living_info = false
    Setting.require_login = false
  end

  context 'with "require login" set' do
    before :each do
      Setting.require_login = true
    end
    it 'hides everything from anonymous users' do
      get "/p/#{@dead.id}"
      expect(response).to have_http_status(:forbidden)
      get "/p/#{@alive.id}"
      expect(response).to have_http_status(:forbidden)
    end

    it 'shows everything to admins' do
      sign_in @admin
      get "/p/#{@dead.id}"
      expect(response).to have_http_status(:success)
      get "/p/#{@alive.id}"
      expect(response).to have_http_status(:success)
    end

    it 'shows everything to users' do
      sign_in @user
      get "/p/#{@dead.id}"
      expect(response).to have_http_status(:success)
      get "/p/#{@alive.id}"
      expect(response).to have_http_status(:success)
    end
  end

  context 'with "restrict living info" set' do
    before :each do
      Setting.restrict_living_info = true
    end
    it 'shows everything to admins' do
      sign_in @admin
      get "/p/#{@alive.id}"
      expect(response).to have_http_status(:success)
      get "/p/#{@dead.id}"
      expect(response).to have_http_status(:success)
      expect(assigns(:children)).to include(@alive)
    end

    it 'shows only dead to users' do
      sign_in @user
      get "/p/#{@alive.id}"
      expect(response).to have_http_status(:forbidden)
      get "/p/#{@dead.id}"
      expect(response).to have_http_status(:success)
      expect(assigns(:children)).to_not include(@alive)
    end

    it 'shows only dead to anonymous users' do
      get "/p/#{@alive.id}"
      expect(response).to have_http_status(:forbidden)
      get "/p/#{@dead.id}"
      expect(response).to have_http_status(:success)
      expect(assigns(:children)).to_not include(@alive)
    end
  end
end
