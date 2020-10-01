require 'rails_helper'

RSpec.describe Photo, type: :request do

  let(:photo) { Photo.new(title: 'Hello world') }
  let(:file) { File.open Rails.root.join('test', 'fixtures', 'files', 'image.jpg') }
  let(:show_path) { "/photos/#{photo.friendly_url}" }
  let(:person) { create(:person) }

  before do
    photo.image.attach(io: file, filename: 'image.jpg')
    photo.save!
  end

  describe '#GET show' do
    context 'when anonymous user visibility' do
      context 'when no login required' do
        before do
          Setting.require_login = false
        end

        context 'when restrict_living_info is false' do
          before do
            Setting.restrict_living_info = false
          end

          it 'returns success' do
            get show_path
            expect(response).to have_http_status(:success)
          end
        end

        context 'when restrict_living_info is true' do
          before do
            Setting.restrict_living_info = true
          end

          context 'when no tagged person associated to photo' do
            it 'returns success' do
              get show_path
              expect(response).to have_http_status(:success)
            end
          end

          context 'when at least one tagged person associated to photo' do
            before do
              photo.tagged_person_list.add(person.id)
              photo.save!
            end

            it 'returns forbidden' do
              get show_path
              expect(response).to have_http_status(:forbidden)
            end
          end
        end
      end

      context 'when require login is true' do
        before do
          Setting.require_login = true
        end

        context 'when restrict_living_info is false' do
          before do
            Setting.restrict_living_info = false
          end

          it 'returns forbidden' do
            get show_path
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when restrict living info is true' do
          it 'returns forbidden' do
            get show_path
            expect(response).to have_http_status(:forbidden)
          end
        end
      end
    end
  end

  context 'when non-admin user visibility' do
    before do
      user = create(:user)
      sign_in user
    end

    context 'when no login required' do
      before do
        Setting.require_login = false
      end

      context 'when restrict_living_info is false' do
        before do
          Setting.restrict_living_info = false
        end

        it 'returns success' do
          get show_path
          expect(response).to have_http_status(:success)
        end
      end

      context 'when restrict_living_info is true' do
        before do
          Setting.restrict_living_info = true
        end

        context 'when no tagged person associated to photo' do
          it 'returns success' do
            get show_path
            expect(response).to have_http_status(:success)
          end
        end

        context 'when at least one tagged person associated to photo' do
          before do
            photo.tagged_person_list.add(person.id)
            photo.save!
          end

          it 'returns forbidden' do
            get show_path
            expect(response).to have_http_status(:forbidden)
          end
        end
      end
    end

    context 'when require login is true' do
      before do
        Setting.require_login = true
      end

      context 'when restrict_living_info is false' do
        before do
          Setting.restrict_living_info = false
        end

        it 'returns success' do
          get show_path
          expect(response).to have_http_status(:success)
        end
      end

      context 'when restrict living info is true' do
        before do
          Setting.restrict_living_info = true
        end

        context 'when no tagged person associated to photo' do
          it 'returns success' do
            get show_path
            expect(response).to have_http_status(:success)
          end
        end

        context 'when at least one tagged person associated to photo' do
          before do
            photo.tagged_person_list.add(person.id)
            photo.save!
          end

          it 'returns forbidden' do
            get show_path
            expect(response).to have_http_status(:forbidden)
          end
        end
      end
    end
  end

  context 'when admin user visibility' do
    before do
      user = create(:user, admin: true)
      sign_in user
    end

    context 'when no login required' do
      before do
        Setting.require_login = false
      end

      context 'when restrict_living_info is false' do
        before do
          Setting.restrict_living_info = false
        end

        it 'returns success' do
          get show_path
          expect(response).to have_http_status(:success)
        end
      end

      context 'when restrict_living_info is true' do
        before do
          Setting.restrict_living_info = true
        end

        context 'when no tagged person associated to photo' do
          it 'returns success' do
            get show_path
            expect(response).to have_http_status(:success)
          end
        end

        context 'when at least one tagged person associated to photo' do
          before do
            photo.tagged_person_list.add(person.id)
            photo.save!
          end

          it 'returns success' do
            get show_path
            expect(response).to have_http_status(:success)
          end
        end
      end
    end

    context 'when require login is true' do
      before do
        Setting.require_login = true
      end

      context 'when restrict_living_info is false' do
        before do
          Setting.restrict_living_info = false
        end

        it 'returns success' do
          get show_path
          expect(response).to have_http_status(:success)
        end
      end

      context 'when restrict living info is true' do
        before do
          Setting.restrict_living_info = true
        end

        context 'when no tagged person associated to photo' do
          it 'returns success' do
            get show_path
            expect(response).to have_http_status(:success)
          end
        end

        context 'when at least one tagged person associated to photo' do
          before do
            photo.tagged_person_list.add(person.id)
            photo.save!
          end

          it 'returns success' do
            get show_path
            expect(response).to have_http_status(:success)
          end
        end
      end
    end
  end
end
