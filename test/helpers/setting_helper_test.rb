# frozen_string_literal: true

class SettingHelperTest < ActionView::TestCase
  test 'should render a setting' do
    Setting.site_title = 'xyzzy'
    assert_equal 'xyzzy', setting(:site_title)
  end
end
