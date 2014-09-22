require 'test_helper'

class ActiveTrailTest < ActionView::TestCase

  test 'active trail in path' do
    set_path '/some-path/other-path'
    assert active_trail?('/')
    assert active_trail?('/some-path')
  end

  test 'active trail same as path' do
    set_path '/'
    assert active_trail?('/')

    set_path '/some-path'
    assert active_trail?('/some-path')
  end

  test 'active trail not in path' do
    set_path '/'
    assert !active_trail?('/some-path')

    set_path '/some-path'
    assert !active_trail?('/other-path')
  end

  private

  def set_path(path)
    self.request = OpenStruct.new(path: path)
  end

end
