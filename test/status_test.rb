require 'test_helper'

class StatusTest < ActionDispatch::IntegrationTest

  test 'error' do
    get '/error.json'
    assert_response 500
    assert_equal ' ', response.body

    get '/error'
    assert_response 500
    assert_equal File.read(Rails.root.join('public', '500.html')), response.body
  end

  test 'not found' do
    get '/not_found.json'
    assert_response 404
    assert_equal ' ', response.body
 
    get '/not_found'
    assert_response 404
    assert_equal File.read(Rails.root.join('public', '404.html')), response.body
  end

  test 'unauthorized' do
    get '/unauthorized.json'
    assert_response 401
    assert_equal ' ', response.body

    get '/unauthorized'
    assert_response 401
    assert_equal File.read(Rails.root.join('public', '422.html')), response.body
  end

  test 'forbidden' do
    get '/forbidden.json'
    assert_response 403
    assert_equal ' ', response.body

    get '/forbidden'
    assert_response 403
    assert_equal File.read(Rails.root.join('public', '422.html')), response.body
  end

  test 'unprocessable entity' do
    get '/unprocessable_entity.json'
    assert_response 422
    assert_equal ' ', response.body

    get '/unprocessable_entity'
    assert_response 422
    assert_equal File.read(Rails.root.join('public', '422.html')), response.body
  end

end
