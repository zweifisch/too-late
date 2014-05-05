# too-late

events with timeouts

```coffee
customer = require('too-late')()

customer.waitfor 'food', (food)->
	console.log "eat #{food}"
.till 30, ->
	console.log 'customer left, you are too late'

setTimeout (-> customer.deliver 'food', 'patato spaghetti'), 40
```

output

```
customer left, you are too late
```
