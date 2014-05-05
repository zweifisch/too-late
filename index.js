// Generated by CoffeeScript 1.7.1
(function() {
  module.exports = function() {
    var callbacks, lastevent, timers;
    callbacks = {};
    timers = {};
    lastevent = null;
    return {
      waitfor: function(event, callback) {
        if (!(event in callbacks)) {
          callbacks[event] = [];
        }
        callbacks[lastevent = event].push(callback);
        return this;
      },
      till: function(timeout, callback) {
        return (function(lastevent) {
          timers[lastevent] = setTimeout((function() {
            delete callbacks[lastevent];
            return callback();
          }), timeout);
          return this;
        })(lastevent);
      },
      deliver: function(event, data) {
        var callback, _i, _len, _ref;
        if (!(event in callbacks)) {
          return;
        }
        clearTimeout(timers[lastevent]);
        _ref = callbacks[event];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          callback = _ref[_i];
          callback(data);
        }
        return this;
      }
    };
  };

}).call(this);
