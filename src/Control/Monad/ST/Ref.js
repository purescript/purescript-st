"use strict";

exports.new = function (val) {
  return function () {
    return { value: val };
  };
};

exports.read = function (ref) {
  return function () {
    return ref.value;
  };
};

exports["modify'"] = function (f) {
  return function (ref) {
    return function () {
      var t = f(ref.value);
      ref.value = t.state;
      return t.value;
    };
  };
};

exports.write = function (a) {
  return function (ref) {
    return function () {
      return ref.value = a; // eslint-disable-line no-return-assign
    };
  };
};
