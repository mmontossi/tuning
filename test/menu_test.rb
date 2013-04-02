require 'test_helper'

class MenuTest < ActiveSupport::TestCase

  setup :set_instance 

  test 'should have active_menu? method' do
    assert @instance.respond_to?(:active_menu?)
  end

  private

  def set_instance
    @instance = ActionView::Base.new
  end

end
