require 'test_helper'

class FlashTest < ActiveSupport::TestCase

  setup :set_instance 

  test 'should have redirect_with_flash method' do
    assert @instance.respond_to?(:redirect_with_flash)
  end

  test 'should have flash_errors method' do
    assert @instance.respond_to?(:flash_errors)
  end

  private

  def set_instance
    @instance = ApplicationController.new
  end

end
