
delay = (cb, time)-> setTimeout time, cb

class Thing

	constructor: ->
		@callbacks = {}
		@timers = {}
		@lastevent = null
		@datas = {}

	waitfor: (event, callback)->
		if typeof event is 'string'
			@callbacks[event] = [] unless event of @callbacks
			@callbacks[@lastevent=event].push callback
			this
		else
			@waitforMany event, callback

	waitforMany: (events, callback)->
		done = 0
		do (events, callback, done)=>
			cb = (data, event)=>
				@datas[event] = data
				if ++ done >= events.length
					callback.apply null, events.map (e)=> @datas[e]
					delete @datas[e] for e in events
					clearTimeout @timers[events.join ',']

			for event in events
				@callbacks[event] = [] unless event of @callbacks
				@callbacks[event].push cb
			@lastevent = events
		this

	till: (timeout, callback)->
		event = @lastevent
		do (event)=>
			if typeof event is 'string'
				@timers[event] = delay timeout, =>
					delete @callbacks[event]
					callback()
			else
				@timers[event.join(',')] = delay timeout, =>
					done = {}
					for e in event
						delete @callbacks[e]
						if e of @datas
							done[e] = @datas[e]
							delete @datas[e]
					callback done
			this

	deliver: (event, data)->
		clearTimeout @timers[event] if event of @timers
		if event of @callbacks
			for callback in @callbacks[event]
				callback data, event
		this

if module?
    module.exports = -> new Thing
else
    @toolate = -> new Thing
