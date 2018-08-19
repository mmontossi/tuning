//= require rails-ujs
//= require turbolinks
//= require_self

const {fire, matches, setData, getData} = Rails;

const Ajax = {
  get: (url, successHandler, errorHandler)=>{
    Rails.ajax({
      url: url,
      type: 'get',
      beforeSend: beforeSend,
      success: successHandler,
      error: errorHandler
    });
  },
  post: (url, data, successHandler, errorHandler)=>{
    Rails.ajax({
      url: url,
      type: 'post',
      data: data,
      beforeSend: beforeSend,
      success: successHandler,
      error: errorHandler
    });
  }
}

var binds = {};

// Rails 5.1.6 hack
function beforeSend(xhr, options) {
  return true;
}

function getMeta(name) {
  let meta = find(document.head, `meta[name=${name}]`);
  return meta.getAttribute('content');
}

function create(html) {
  let template = document.createElement('template');
  template.innerHTML = html.trim();
  return template.content.firstChild;
}

function replace(previous, current) {
  if (typeof current === 'string') {
    current = create(current);
  }
  previous.parentNode.replaceChild(current, previous);
}

function remove(element) {
  element.parentNode.removeChild(element);
}

function append(parent, element) {
  if (typeof element === 'string') {
    element = create(element);
  }
  parent.appendChild(element);
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
  let parent = element.parentNode;
  if (parent instanceof Element) {
    if (matches(parent, selector)) {
      return parent;
    } else {
      return findParent(parent, selector);
    }
  }
}

function listen() {
  let elements, selector, type, handler;
  if (arguments.length == 3) {
    [elements, type, handler] = arguments;
  } else {
    [elements, selector, type, handler] = arguments;
  }
  if (elements.constructor != Array) {
    elements = [elements];
  }
  for (let element of elements) {
    element.addEventListener(type, (event)=>{
      let currentTarget = event.target;
      if (selector && !matches(currentTarget, selector)) {
        currentTarget = findParent(currentTarget, selector);
      }
      event = Object.defineProperty(event, 'currentTarget', { value: currentTarget, configurable: true });
      if (currentTarget && handler.call(event.target, event) == false) {
        event.preventDefault();
        event.stopPropagation();
      }
    });
  }
}

function load(scope) {
  for (let [selector, klass] of Object.entries(binds)) {
    let elements = findAll(scope, selector);
    for (let element of elements) {
      new klass(element);
    }
  }
}

listen(document, 'turbolinks:load', ()=>{
  load(document.body);
  let observer = new MutationObserver((mutations)=>{
    for (let mutation of mutations) {
      load(mutation.target);
    }
  });
  observer.observe(
    document.body,
    { attributes: false, childList: true, subtree: true }
  );
});

