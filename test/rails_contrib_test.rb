require 'test_helper'

class RailsContribTest < ActiveSupport::TestCase

  test 'truth' do
    assert_kind_of Module, Rails::Contrib
  end

end
