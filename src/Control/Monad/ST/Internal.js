"use strict";

export var map_ = function (f) {
  return function (a) {
    return function () {
      return f(a());
    };
  };
};

export var pure_ = function (a) {
  return function () {
    return a;
  };
};

export var bind_ = function (a) {
  return function (f) {
    return function () {
      return f(a())();
    };
  };
};

export var run = function (f) {
  return f();
};

export var while_ = function (f) {
  return function (a) {
    return function () {
      while (f()) {
        a();
      }
    };
  };
};

export var for_ = function (lo) {
  return function (hi) {
    return function (f) {
      return function () {
        for (var i = lo; i < hi; i++) {
          f(i)();
        }
      };
    };
  };
};

export var foreach = function (as) {
  return function (f) {
    return function () {
      for (var i = 0, l = as.length; i < l; i++) {
        f(as[i])();
      }
    };
  };
};

export var new = function (val) {
  return function () {
    return { value: val };
  };
};

export var read = function (ref) {
  return function () {
    return ref.value;
  };
};

export var modifyImpl = function (f) {
  return function (ref) {
    return function () {
      var t = f(ref.value);
      ref.value = t.state;
      return t.value;
    };
  };
};

export var write = function (a) {
  return function (ref) {
    return function () {
      return ref.value = a; // eslint-disable-line no-return-assign
    };
  };
};
