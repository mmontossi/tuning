require 'test_helper'

class ViewTest < ActiveSupport::TestCase

  setup do
    @instance = ActionView::Base.new
  end

  test "should have contenta_tag_if method" do
    assert @instance.respond_to?(:content_tag_if)
  end

  test "should have active_menu? method" do
    assert @instance.respond_to?(:active_menu?)
  end

end
