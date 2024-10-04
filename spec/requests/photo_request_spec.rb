require "rails_helper"

RSpec.describe Photo do
  let(:photo) { described_class.new(title: "Hello world") }
  let(:file) { Rails.root.join("spec/fixtures/files/image.jpg").open }
  let(:show_path) { "/photos/#{photo.friendly_url}" }
  let(:person) do
    create(:person) do |p|
      create_list(:fact, 1, :birth, factable: p)
      p.save_without_history!
    end
  end
  let(:dead_person) do
    create(:person) do |p|
      create_list(:fact, 1, :death, factable: p)
      p.save_without_history!
    end
  end

  before do
    photo.image.attach(io: file, filename: "image.jpg")
    photo.save_without_history!
  end

  describe "#GET show" do
    context "when anonymous user visibility" do
      context "when no login required" do
        before do
          Setting.require_login = false
        end

        context "when restrict_living_info is false" do
          before do
            Setting.restrict_living_info = false
          end

          it "returns success" do
            get show_path
            expect(response).to have_http_status(:success)
          end
        end

        context "when restrict_living_info is true" do
          before do
            Setting.restrict_living_info = true
          end

          context "when no tagged person associated to photo" do
            it "returns success" do
              get show_path
              expect(response).to have_http_status(:success)
            end
          end

          context "when at least one tagged person associated to photo" do
            it "returns forbidden" do
              photo.tagged_person_list.add(person.id)
              photo.save_without_history!

              get show_path
              expect(response).to have_http_status(:forbidden)
            end

            it "succeeds if there are only dead people" do
              photo.tagged_person_list = [dead_person.id]
              photo.save_without_history!

              get show_path
              expect(response).to have_http_status(:success)
            end
          end
        end
      end

      context "when require login is true" do
        before do
          Setting.require_login = true
        end

        context "when restrict_living_info is false" do
          before do
            Setting.restrict_living_info = false
          end

          it "returns forbidden" do
            get show_path
            expect(response).to have_http_status(:forbidden)
          end
        end

        context "when restrict living info is true" do
          it "returns forbidden" do
            get show_path
            expect(response).to have_http_status(:forbidden)
          end
        end
      end
    end
  end

  context "when non-admin user visibility" do
    before do
      user = create(:user)
      sign_in user
    end

    context "when no login required" do
      before do
        Setting.require_login = false
      end

      context "when restrict_living_info is false" do
        before do
          Setting.restrict_living_info = false
        end

        it "returns success" do
          get show_path
          expect(response).to have_http_status(:success)
        end
      end

      context "when restrict_living_info is true" do
        before do
          Setting.restrict_living_info = true
        end

        context "when no tagged person associated to photo" do
          it "returns success" do
            get show_path
            expect(response).to have_http_status(:success)
          end
        end

        context "when at least one tagged person associated to photo" do
          before do
            photo.tagged_person_list.add(person.id)
            photo.save_without_history!
          end

          it "returns forbidden" do
            get show_path
            expect(response).to have_http_status(:forbidden)
          end
        end
      end
    end

    context "when require login is true" do
      before do
        Setting.require_login = true
      end

      context "when restrict_living_info is false" do
        before do
          Setting.restrict_living_info = false
        end

        it "returns success" do
          get show_path
          expect(response).to have_http_status(:success)
        end
      end

      context "when restrict living info is true" do
        before do
          Setting.restrict_living_info = true
        end

        context "when no tagged person associated to photo" do
          it "returns success" do
            get show_path
            expect(response).to have_http_status(:success)
          end
        end

        context "when at least one alive tagged person associated to photo" do
          before do
            photo.tagged_person_list.add(person.id)
            photo.save_without_history!
          end

          it "returns forbidden" do
            get show_path
            expect(response).to have_http_status(:forbidden)
          end
        end
      end
    end
  end

  context "when admin user visibility" do
    before do
      user = create(:user, admin: true)
      sign_in user
    end

    context "when no login required" do
      before do
        Setting.require_login = false
      end

      context "when restrict_living_info is false" do
        before do
          Setting.restrict_living_info = false
        end

        it "returns success" do
          get show_path
          expect(response).to have_http_status(:success)
        end
      end

      context "when restrict_living_info is true" do
        before do
          Setting.restrict_living_info = true
        end

        context "when no tagged person associated to photo" do
          it "returns success" do
            get show_path
            expect(response).to have_http_status(:success)
          end
        end

        context "when at least one tagged person associated to photo" do
          before do
            photo.tagged_person_list.add(person.id)
            photo.save_without_history!
          end

          it "returns success" do
            get show_path
            expect(response).to have_http_status(:success)
          end
        end
      end
    end

    context "when require login is true" do
      before do
        Setting.require_login = true
      end

      context "when restrict_living_info is false" do
        before do
          Setting.restrict_living_info = false
        end

        it "returns success" do
          get show_path
          expect(response).to have_http_status(:success)
        end
      end

      context "when restrict living info is true" do
        before do
          Setting.restrict_living_info = true
        end

        context "when no tagged person associated to photo" do
          it "returns success" do
            get show_path
            expect(response).to have_http_status(:success)
          end
        end

        context "when at least one tagged person associated to photo" do
          before do
            photo.tagged_person_list.add(person.id)
            photo.save_without_history!
          end

          it "returns success" do
            get show_path
            expect(response).to have_http_status(:success)
          end
        end
      end
    end
  end
end
