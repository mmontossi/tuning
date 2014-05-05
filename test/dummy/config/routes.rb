Dummy::Application.routes.draw do
  
  get 'exception' => 'status#exception_action'
  get 'error' => 'status#error_action'
  get 'not_found' => 'status#not_found_action'
  get 'unauthorized' => 'status#unauthorized_action'
  get 'forbidden' => 'status#forbidden_action'
  get 'unprocessable_entity' => 'status#unprocessable_entity_action'

end
