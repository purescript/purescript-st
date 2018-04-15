"use strict";

exports.map_ = function (f) {
  return function (a) {
    return function () {
      return f(a());
    };
  };
};

exports.pure_ = function (a) {
  return function () {
    return a;
  };
};

exports.bind_ = function (a) {
  return function (f) {
    return function () {
      return f(a())();
    };
  };
};

exports.run = function (f) {
  return f();
};

exports["while"] = function (f) {
  return function (a) {
    return function () {
      while (f()) {
        a();
      }
    };
  };
};
