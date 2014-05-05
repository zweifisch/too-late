
module.exports = ->

	callbacks = {}
	timers = {}
	lastevent = null

	waitfor: (event, callback)->
		callbacks[event] = [] unless event of callbacks
		callbacks[lastevent=event].push callback
		this

	till: (timeout, callback)-> do (lastevent)->
		timers[lastevent] = setTimeout (->
			delete callbacks[lastevent]
			callback()
		), timeout
		this

	deliver: (event, data)->
		return unless event of callbacks
		clearTimeout timers[lastevent]
		for callback in callbacks[event]
			callback data
		this
