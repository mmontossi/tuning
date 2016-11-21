require 'test_helper'

class HelpersTest < ActionView::TestCase
  include Tuning::Extensions::ActionView::Base

  test 'active trail' do
    set_path '/some-path/other-path'
    assert active_trail?('/')
    assert active_trail?('/some-path')

    set_path '/'
    assert active_trail?('/')
    set_path '/some-path'
    assert active_trail?('/some-path')

    set_path '/'
    assert_not active_trail?('/some-path')
    set_path '/some-path'
    assert_not active_trail?('/other-path')
  end

  test 'content tag if' do
    assert_equal(
      'content',
      content_tag_if(false, :a) { 'content' }
    )
    assert_equal(
      '<a>content</a>',
      content_tag_if(true, :a) { 'content' }
    )
    assert_equal(
      '<a href="#">content</a>',
      content_tag_if(true, :a, href: '#') { 'content' }
    )
  end

  test 'extending' do
    assert_equal(
      '<!DOCTYPE html><p>content</p>',
      render(template: 'layouts/market').gsub(/\n\s+/, '')
    )
  end

  private

  def set_path(path)
    self.request = ActionDispatch::TestRequest.new
    self.request.path = path
  end

end
