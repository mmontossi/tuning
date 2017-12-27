//= require rails-ujs
//= require turbolinks

const {matches, setData, getData} = Rails;

const Ajax = {

  get: (url, successHandler, errorHandler)=>{
    Rails.ajax({
      url: url,
      type: 'get',
      success: successHandler,
      error: errorHandler
    });
  },

  post: (url, data, successHandler, errorHandler)=>{
    Rails.ajax({
      url: url,
      type: 'post',
      data: data,
      success: successHandler,
      error: errorHandler
    });
  }

}

function getMeta(name) {
  let meta = find(document.head, `meta[name=${name}]`);
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
    scope = document.body;
    selector = arguments[0];
  }
  let list = scope.querySelectorAll(selector);
  return Array.prototype.slice.call(list);
}

function findParent(element, selector) {
  parent = element.parentNode;
  if (parent instanceof Element) {
    if (matches(element, selector)) {
      return parent;
    } else {
      return findParent(parent, selector);
    }
  }
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
      target = findParent(target, selector);
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

function bind() {
  listen(document, 'turbolinks:load', ()=>{
    load(document.body, arguments);
    let observer = new MutationObserver((mutations)=>{
      for (let mutation of mutations) {
        load(mutation.target, arguments);
      }
    });
    observer.observe(document.body, { attributes: false, childList: true, subtree: true });
  });
}
