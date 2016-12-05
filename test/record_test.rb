require 'test_helper'

class RecordTest < ActiveSupport::TestCase

  test 'nilify blanks' do
    user = User.new(name: '')
    user.save
    assert_nil user.name
    assert_nil user.reload.name
  end

  test 'validate' do
    assert User.new.respond_to?(:validate)
  end

end
