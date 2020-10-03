require 'rails_helper'

RSpec.describe Ajax::AjaxController, type: :request do
  let(:person) { create(:person) }

  before do
    sign_in(user)
  end

  describe '#GET tags' do
    context 'with admin user' do
      let(:user) { create(:user, admin: true) }

      it 'returns success' do
        get ajax_tags_path
        expect(response).to have_http_status(:success)
      end
    end

    context 'with non-admin user' do
      let(:user) { create(:user) }

      it 'returns unauthorized' do
        get ajax_tags_path
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe '#GET people_tags' do
    context 'with admin user' do
      let(:user) { create(:user, admin: true) }

      it 'returns success' do
        get ajax_people_tags_path
        expect(response).to have_http_status(:success)
      end
    end

    context 'with non-admin user' do
      let(:user) { create(:user) }

      it 'returns unauthorized' do
        get ajax_people_tags_path
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe '#GET people_tag' do
    context 'with admin user' do
      let(:user) { create(:user, admin: true) }

      it 'returns success' do
        get ajax_people_tag_path(person.id)
        expect(response).to have_http_status(:success)
      end
    end

    context 'with non-admin user' do
      let(:user) { create(:user) }

      it 'returns unauthorized' do
        get ajax_people_tag_path(person.id)
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
