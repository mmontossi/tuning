require 'test_helper'

class ErrorTest < ActiveSupport::TestCase

  setup :set_instance

  test 'should have not_found method' do
    assert @instance.respond_to?(:not_found)
  end

  test 'should have forbidden method' do
    assert @instance.respond_to?(:forbidden)
  end

  private

  def set_instance
    @instance = ApplicationController.new
  end

end
