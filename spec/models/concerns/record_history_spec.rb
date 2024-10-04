# frozen_string_literal: true

require "rails_helper"

RSpec.describe "RecordHistory" do
  let(:person) { create(:person) }

  describe "when User.current_user is set" do
    let(:user) { create(:user) }

    before do
      allow(User).to receive(:current_user).and_return(user)
    end

    context "when creating a model" do
      before do
        Person.create!(first_name: "Deanna", last_name: "Troi")
      end

      it "writes a create history" do
        expect(EditHistory.last.attributes.values_at("action", "editable_type", "editable_id")).to eq(
          ["create", "Person", Person.last.id]
        )
      end
    end

    context "when updating a model" do
      let(:person) { create(:person, first_name: "Deanna", last_name: "Troi") }

      before do
        person.update!(first_name: "Lwaxana")
      end

      it "writes an update history" do
        expect(EditHistory.last.attributes.values_at("action", "editable_type", "editable_id")).to eq(
          ["update", "Person", Person.last.id]
        )
      end
    end
  end

  describe "when User.current_user is not set" do
    before do
      allow(User).to receive(:current_user).and_return(nil)
    end

    context "when creating a model" do
      it "does not write a create history" do
        expect(EditHistory.all.size).to be(0)
      end
    end

    context "when updating a model" do
      it "does not write an update history" do
        expect(EditHistory.all.size).to be(0)
      end
    end
  end
end
