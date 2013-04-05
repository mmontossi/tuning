require 'test_helper'

class ControllerTest < ActiveSupport::TestCase

  setup :set_instance

  test 'should have not_found method' do
    assert @instance.respond_to?(:not_found)
  end

  test 'should have forbidden method' do
    assert @instance.respond_to?(:forbidden)
  end

  test 'should have redirect_with_flash method' do
    assert @instance.respond_to?(:redirect_with_flash)
  end

  test 'should have flash_errors method' do
    assert @instance.respond_to?(:flash_errors)
  end

  protected

  def set_instance
    @instance = ApplicationController.new
  end

end
