class StatusController < ApplicationController

  def exception_action
    raise 'error'
  end

  def error_action
    error
  end

  def not_found_action
    not_found
  end

  def unauthorized_action
    unauthorized
  end

  def forbidden_action
    forbidden
  end

  def unprocessable_entity_action
    unprocessable_entity
  end

end
