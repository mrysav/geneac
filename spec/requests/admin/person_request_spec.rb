# frozen_string_literal: true

require "rails_helper"
require_relative "../helpers/history_helper"

RSpec.describe Person, type: :request do
  let(:admin) { create(:user, :admin) }

  before do
    login_as admin
  end

  describe "#POST create" do
    before do
      post admin_people_path, params: { person: { first_name: "William", last_name: "Riker" } }
    end

    it "creates the person" do
      expect(described_class.last.full_name).to eq("William Riker")
    end

    it_behaves_like "records the edit history" do
      let(:action) { "create" }
      let(:resource) { described_class.last }
      let(:edited_at) { described_class.last.created_at }
      let(:user) { admin }
    end
  end

  describe "#PUT update" do
    let(:person) { create(:person, first_name: "William", last_name: "Riker") }

    before do
      put admin_person_path(id: person.id), params: { person: { first_name: "Kyle" } }
    end

    it "updates the person" do
      expect(person.reload.full_name).to eq("Kyle Riker")
    end

    it_behaves_like "records the edit history" do
      let(:action) { "update" }
      let(:resource) { described_class.last }
      let(:edited_at) { described_class.last.updated_at }
      let(:user) { admin }
    end
  end
end
