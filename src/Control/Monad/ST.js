"use strict";

exports.mapST = function (f) {
  return function (a) {
    return function () {
      return f(a());
    };
  };
};

exports.pureST_ = function (a) {
  return function () {
    return a;
  };
};

exports.bindST_ = function (a) {
  return function (f) {
    return function () {
      return f(a())();
    };
  };
};

exports.newSTRef = function (val) {
  return function () {
    return { value: val };
  };
};

exports.readSTRef = function (ref) {
  return function () {
    return ref.value;
  };
};

exports.modifySTRef = function (ref) {
  return function (f) {
    return function () {
      return ref.value = f(ref.value); // eslint-disable-line no-return-assign
    };
  };
};

exports.writeSTRef = function (ref) {
  return function (a) {
    return function () {
      return ref.value = a; // eslint-disable-line no-return-assign
    };
  };
};

exports.pureST = function (f) {
  return f();
};
