//= require rails-ujs
//= require turbolinks

const {delegate, ajax, matches, $} = Rails;

function setting(name) {
  let meta = find(`meta[name=${name}]`);
  return meta.getAttribute('content');
}

function post(url, data, successHandler, errorHandler) {
  ajax({
    url: url,
    type: 'post',
    data: data,
    success: successHandler,
    error: errorHandler
  })
}

function get(url, successHandler, errorHandler) {
  ajax({
    url: url,
    type: 'get',
    success: successHandler,
    error: errorHandler
  })
}

function find() {
  let elements = findAll(...arguments);
  return (elements.length > 0 ? elements[0] : null);
}

function findAll() {
  let scope, selector;
  if (arguments.length == 2) {
    [scope, selector] = arguments;
  } else {
    scope = document;
    selector = arguments[0];
  }
  let list = scope.querySelectorAll(selector);
  return Array.prototype.slice.call(list);
}

function closest(element, selector) {
  while (element instanceof Element) {
    if (matches(element, selector)) {
      return element;
    } else {
      element = element.parentNode;
    }
  }
}
