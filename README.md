# too-late

events with timeouts

```coffee
customer = require('too-late')()

customer.waitfor 'food', (food)->
	console.log "eat #{food}"
.till 3, ->
	console.log 'customer left, you are too late'

setTimeout (-> customer.deliver 'food', 'patato spaghetti') 5
setTimeout (-> customer.deliver 'food', 'patato salad') 2
```
