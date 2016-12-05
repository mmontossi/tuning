require 'test_helper'

class ControllerTest < ActiveSupport::TestCase

  test 'render' do
    controller = ActionController::Base.new
    controller.expects(:run_callbacks).with(:render)
    controller.render
  end

  test 'callbacks' do
    controller = ActionController::Base
    %i(before after around).each do |callback|
      assert controller.respond_to?("#{callback}_render")
      assert controller.respond_to?("append_#{callback}_render")
      assert controller.respond_to?("prepend_#{callback}_render")
      assert controller.respond_to?("skip_#{callback}_render")
    end
  end

end
