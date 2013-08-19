require 'test_helper'

class ViewTest < ActiveSupport::TestCase

  setup do
    @instance = ActionView::Base.new
  end

  test "should have conditional_tag method" do
    assert @instance.respond_to?(:conditional_tag)
  end

  test "should have active_menu? method" do
    assert @instance.respond_to?(:active_menu?)
  end

end
