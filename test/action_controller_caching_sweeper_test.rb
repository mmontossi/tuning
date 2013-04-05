require 'test_helper'

class ActionControllerCachingSweeperTest < ActiveSupport::TestCase

  setup :set_instance

  test 'should have not_found method' do
    assert @instance.respond_to?(:increment_cache_namespace)
  end

  protected

  def set_instance
    @instance = ActionController::Caching::Sweeper.instance
  end

end
