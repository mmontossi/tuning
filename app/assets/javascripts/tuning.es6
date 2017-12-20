//= require rails-ujs
//= require turbolinks

const {matches, setData, getData} = Rails;

function meta(name) {
  let meta = find(`meta[name=${name}]`);
  return meta.getAttribute('content');
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

function get(url, successHandler, errorHandler) {
  Rails.ajax({
    url: url,
    type: 'get',
    success: successHandler,
    error: errorHandler
  })
}

function post(url, data, successHandler, errorHandler) {
  Rails.ajax({
    url: url,
    type: 'post',
    data: data,
    success: successHandler,
    error: errorHandler
  })
}

function listen() {
  let element, selector, type, handler;
  if (arguments.length == 3) {
    [element, type, handler] = arguments;
  } else {
    [element, selector, type, handler] = arguments;
  }
  element.addEventListener(type, (event)=>{
    let target = event.target;
    if (selector) {
      target = closest(target, selector);
    }
    if (target && handler.call(target, event) == false) {
      event.preventDefault();
      event.stopPropagation();
    }
  });
}

function load(scope, list) {
  for (let [selector, klass] of list) {
    let elements = findAll(scope, selector);
    for (let element of elements) {
      new klass(element);
    }
  }
}

function observe() {
  listen(document, 'turbolinks:load', ()=>{
    load(document, arguments);
    let observer = new MutationObserver((mutations)=>{
      for (let mutation of mutations) {
        load(mutation.target, arguments);
      }
    });
    let body = find('body');
    observer.observe(body, { attributes: false, childList: true, subtree: true });
  });
}
