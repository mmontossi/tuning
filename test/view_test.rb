require 'test_helper'

class ViewTest < ActionDispatch::IntegrationTest

  test 'handler' do
    users = %w(mario juan).map do |name|
      User.create(name: name).slice :name
    end

    get '/users.json'
    assert_equal users.to_json, response.body

    get '/users.xml'
    assert_equal users.to_xml, response.body
  end

end
