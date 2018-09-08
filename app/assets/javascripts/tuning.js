//= require rails-ujs
//= require turbolinks
//= require_self

const {fire, matches} = Rails;

var views = {};
var binds = {};

function get() {
  let args = castArray(arguments);
  args.unshift('get');
  request(...args);
}

function post() {
  let args = castArray(arguments);
  args.unshift('post');
  request(...args);
}

function castArray(object) {
  return Array.prototype.slice.call(object);
}

function request() {
  let type, url, data, successHandler, errorHandler;
  let options = { beforeSend: beforeSend }
  if (typeof arguments[2] == 'object') {
    [type, url, data, successHandler, errorHandler] = arguments;
  } else {
    [type, url, successHandler, errorHandler] = arguments;
  }
  options.type = type;
  options.url = url;
  options.success = successHandler;
  options.error = errorHandler;
  if (type == 'get' && data) {
    options.url += '?';
    let params = [];
    for (let key in data) {
      let value = escape(data[key]);
      let param = (key+'='+value);
      params.push(param);
    }
    options.url += params.join('&');
  } else {
    options.data = data;
  }
  Rails.ajax(options);
}

function render(name, options) {
  let output = views[name];
  for (let key in options) {
    let pattern = ('#{'+key+'}');
    let regex = new RegExp(pattern, 'g');
    let value = options[key];
    output = output.replace(regex, value);
  }
  return output;
}

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
  if (HTMLCollection.prototype.isPrototypeOf(elements)) {
    elements = Array.prototype.slice.call(elements);
  } else {
    elements = [elements];
  }
  for (let element of elements) {
    element.addEventListener(type, (event)=>{
      let currentTarget = event.target;
      if (selector && !matches(currentTarget, selector)) {
        currentTarget = findParent(currentTarget, selector);
      }
      event = Object.defineProperty(
        event,
        'currentTarget',
        { value: currentTarget, configurable: true }
      );
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

