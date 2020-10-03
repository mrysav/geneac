require 'rails_helper'

RSpec.describe Note, type: :request do

  let(:note) { create(:note) }
  let(:show_path) { note_path(note.friendly_url) }
  let(:person) { create(:person) }

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

          context 'when no tagged person associated to note' do
            it 'returns success' do
              get show_path
              expect(response).to have_http_status(:success)
            end
          end

          context 'when at least one tagged person associated to note' do
            before do
              note.tagged_person_list.add(person.id)
              note.save!
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

        context 'when no tagged person associated to note' do
          it 'returns success' do
            get show_path
            expect(response).to have_http_status(:success)
          end
        end

        context 'when at least one tagged person associated to note' do
          before do
            note.tagged_person_list.add(person.id)
            note.save!
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

        context 'when no tagged person associated to note' do
          it 'returns success' do
            get show_path
            expect(response).to have_http_status(:success)
          end
        end

        context 'when at least one tagged person associated to note' do
          before do
            note.tagged_person_list.add(person.id)
            note.save!
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

        context 'when no tagged person associated to note' do
          it 'returns success' do
            get show_path
            expect(response).to have_http_status(:success)
          end
        end

        context 'when at least one tagged person associated to note' do
          before do
            note.tagged_person_list.add(person.id)
            note.save!
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

        context 'when no tagged person associated to note' do
          it 'returns success' do
            get show_path
            expect(response).to have_http_status(:success)
          end
        end

        context 'when at least one tagged person associated to note' do
          before do
            note.tagged_person_list.add(person.id)
            note.save!
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
