require 'test_helper'

class ButtonTest < ActionView::TestCase
 
  test 'button with span' do
    assert_equal(
      '<button name="commit" type="submit"><span>Send</span></button>',
      submit_tag
    )
  end

  test 'label value' do
    assert_equal(
      '<button name="commit" type="submit"><span>Other</span></button>',
      submit_tag('Other')
    )
  end

  test 'attributes options' do
    assert_equal(
      '<button attribute="value" name="commit" type="submit"><span>Send</span></button>',
      submit_tag('Send', attribute: 'value')
    )
  end

end
