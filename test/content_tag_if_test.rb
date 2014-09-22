require 'test_helper'

class ContentTagIfTest < ActionView::TestCase

  test 'true condition' do
    assert_equal '<a>content</a>', content_tag_if(1 == 1, 'a') { 'content' }
  end

  test 'false condition' do
    assert_equal 'content', content_tag_if(1 == 2, 'a') { 'content' }
  end

  test 'attributes options' do
    assert_equal '<a href="#">content</a>', content_tag_if(1 == 1, 'a', href: '#') { 'content' }
  end

end
