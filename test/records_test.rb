require 'test_helper'

class RecordsTest < ActiveSupport::TestCase

  test 'nilify blanks' do
    shop = Shop.new(name: '')
    shop.save
    assert_nil shop.name
    assert_nil shop.reload.name
  end

  test 'validate' do
    assert Shop.new.respond_to?(:validate)
  end

end
