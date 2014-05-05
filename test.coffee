
customer = require('too-late')()


it 'should be on time', (done)->

	customer.waitfor 'food', (food)->
		done()
	.till 3, ->
		done new Error 'should not be too late'

	setTimeout (-> customer.deliver 'food', 'patato salad'), 2

it 'should be too late', (done)->

	customer.waitfor 'food', (food)->
		done new Error 'should not be on time'
	.till 3, ->
		done()

	setTimeout (-> customer.deliver 'food', 'patato spaghetti'), 4
