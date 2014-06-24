require 'test_helper'

class ContentTagIfTest < ActionView::TestCase

  test "show tag if condition is true" do
    assert_equal '<a>content</a>', content_tag_if(1 == 1, 'a') { 'content' }
  end

  test "not show tag if condition if false" do
    assert_equal 'content', content_tag_if(1 == 2, 'a') { 'content' }
  end

  test "accept options as attributes" do
    assert_equal '<a href="#">content</a>', content_tag_if(1 == 1, 'a', href: '#') { 'content' }
  end

end
