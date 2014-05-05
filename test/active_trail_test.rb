require 'test_helper'

class ActiveTrailTest < ActionView::TestCase

  test "should return true if path is in active trail" do
    set_path '/some-path/other-path'
    assert active_trail?('/')
    assert active_trail?('/some-path')
  end

  test "should return true if path is the same as active trail" do
    set_path '/'
    assert active_trail?('/')

    set_path '/some-path'
    assert active_trail?('/some-path')
  end

  test "should return false if path is not in active trail" do
    set_path '/'
    assert_not active_trail?('/some-path')

    set_path '/some-path'
    assert_not active_trail?('/other-path')
  end

  private

  def set_path(path)
    self.request = OpenStruct.new(path: path)
  end

end
