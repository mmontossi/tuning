require 'test_helper'

class HamlTest < ActiveSupport::TestCase

  setup :set_instance 

  test 'should have conditional_tag method' do
    assert @instance.respond_to?(:conditional_tag)
  end

  protected

  def set_instance
    @instance = ActionView::Base.new
  end

end
