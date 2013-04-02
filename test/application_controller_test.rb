require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase

  test 'should have redirect_with_flash method' do
    assert @controller.respond_to?(:redirect_with_flash)
  end

  test 'should have flash_errors method' do
    assert @controller.respond_to?(:flash_errors)
  end

end
