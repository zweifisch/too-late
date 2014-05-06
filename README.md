# too late

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
