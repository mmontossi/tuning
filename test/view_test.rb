require 'test_helper'

class HelpersTest < ActiveSupport::TestCase

  setup :set_instance 

  test "should have conditional_tag method" do
    assert @instance.respond_to?(:conditional_tag)
  end

  test "should have active_menu? method" do
    assert @instance.respond_to?(:active_menu?)
  end

  protected

  def set_instance
    @instance = ActionView::Base.new
  end

end
