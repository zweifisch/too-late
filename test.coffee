
customer = require('too-late')()


it 'should be on time', (done)->

	customer.waitfor 'food', (food)->
		done()
	.till 30, ->
		done new Error 'should not be too late'

	setTimeout (-> customer.deliver 'food', 'patato salad'), 20

it 'should be too late', (done)->

	customer.waitfor 'food', (food)->
		done new Error 'should not be on time'
	.till 30, ->
		done()

	setTimeout (-> customer.deliver 'food', 'patato spaghetti'), 40
