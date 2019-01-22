# frozen_string_literal: true

class MarkdownHelperTest < ActionView::TestCase
  test 'should render markdown' do
    assert_equal "<p><em>Lorem Ipsum</em></p>\n", markdown('*Lorem Ipsum*')
  end
end
