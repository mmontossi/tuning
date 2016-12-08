require 'test_helper'

class ControllerTest < ActiveSupport::TestCase

  test 'render' do
    controller = ActionController::Base.new
    controller.expects(:run_callbacks).with(:render)
    controller.render
  end

  test 'callbacks' do
    controller = ActionController::Base
    %w(before after around).each do |callback|
      ['', 'append_', 'prepend_', 'skip_'].each do |prefix|
        assert_nothing_raised do
          controller.send "#{prefix}#{callback}_render", :foo
        end
      end
    end
  end

end
