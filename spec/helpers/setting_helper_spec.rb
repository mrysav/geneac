require 'rails_helper'

RSpec.describe SettingHelper, type: :helper do
  let(:helper) { Setting }
  let(:site_title_setting) { 'xyzzy' }
  before do
    Setting.site_title = site_title_setting
  end

  describe '#site_title' do
    it 'renders the site title setting' do
      expect(setting(:site_title)).to eq site_title_setting
    end
  end
end
