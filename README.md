# too late

[![NPM Version][npm-image]][npm-url]
[![Build Status][travis-image]][travis-url]

events with timeouts

```sh
npm install 'too-late'
```

```javascript
var customer = require('too-late')();

customer.waitfor('food', function(food) {
	console.log("eat " + food);
}).till(30, function() {
	console.log('customer left, you are too late');
});

setTimeout(function() {
	customer.deliver('food', 'patato spaghetti');
}, 40):
```

output

```
customer left, you are too late
```

wait for multiple events

```javascript
var customer = require('too-late')();
customer.waitfor(['food', 'drink'], function(food, drink) {
	console.log(food + " and " + drink);
}).till(50, function(served) {
	console.log('customer left, you are too late');
});

setTimeout(function() {
	customer.deliver('food', 'patato spaghetti');
}, 20):

setTimeout(function() {
	customer.deliver('drink', 'soda water');
}, 40):
```

[npm-image]: https://img.shields.io/npm/v/too-late.svg?style=flat
[npm-url]: https://npmjs.org/package/too-late
[travis-image]: https://img.shields.io/travis/zweifisch/too-late.svg?style=flat
[travis-url]: https://travis-ci.org/zweifisch/too-late
