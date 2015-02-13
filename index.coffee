AssocList = require "./AssocList"

delay = (cb, time)-> setTimeout time, cb

class Thing

    constructor: ->
        @callbacks = new AssocList
        @timers = new AssocList
        @lastevent = null
        @datas = new AssocList

    waitfor: (event, callback)->
        if typeof event is 'string'
            pushed = @callbacks.swapItem event, (cbs)->
                cbs.push callback
                cbs
            if not pushed
                @callbacks.appendItem event, [callback]
            @lastevent=event
            this
        else
            @waitforMany event, callback

    waitforMany: (events, callback)->
        done = 0
        do (events, callback, done)=>
            cb = (data, event)=>
                @datas.swapItem(event, -> data) or @datas.appendItem event, data
                if ++ done >= events.length
                    callback.apply null, events.map (e)=> @datas.getItem e
                    @datas.deleteItem e for e in events
                    clearTimeout @timers.deleteItem events.join ','

            for event in events
                pushed = @callbacks.swapItem event, (cbs)->
                    cbs.push cb
                    cbs
                if not pushed
                    @callbacks.appendItem event, [cb]
            @lastevent = events
        this

    till: (timeout, callback)->
        event = @lastevent
        do (event)=>
            if typeof event is 'string'
                @timers.appendItem event, delay timeout, =>
                    @callbacks.deleteItem event
                    callback()
            else
                @timers.appendItem event.join(','), delay timeout, =>
                    done = {}
                    for e in event
                        @callbacks.deleteItem e
                        done[e] = @datas.deleteItem e
                    callback done
            this

    deliver: (event, data)->
        clearTimeout @timers.deleteItem event
        if callbacks = @callbacks.deleteItem event
            for callback in callbacks
                callback data, event
        this

if module?
    module.exports = -> new Thing
else
    @toolate = -> new Thing
