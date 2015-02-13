assert = require "assert"

AssocList = require "./AssocList"

delay = (time, cb)-> setTimeout cb, time

describe "assoc list", ->

    it "should append", ->
        alist = new AssocList
        alist.appendItem("key", "val")
        alist.appendItem("key2", "val")
        assert.deepEqual alist.toArray(), [["key", "val"], ["key2", "val"]]

    it "should get", ->
        alist = new AssocList
        alist.appendItem("key", "val")
        alist.appendItem("key2", "val2")
        assert.deepEqual alist.getItem("key"), "val"
        assert.deepEqual alist.getItem("key2"), "val2"

    it 'should swap', ->
        alist = new AssocList
        alist.appendItem("key", "val")
        alist.swapItem "key", (val)-> val.length
        assert.equal alist.getItem("key"), 3

        swapped = alist.swapItem "key2", (val)-> val.length
        assert.equal swapped, no

    it "should delete", ->
        alist = new AssocList
        alist.appendItem("key", "val")
        alist.appendItem("key2", "val2")
        assert.equal "val2", alist.deleteItem "key2"
        assert.deepEqual alist.toArray(), [["key", "val"]]

        assert.equal "val", alist.deleteItem "key"
        assert.deepEqual alist.toArray(), []

describe "too late", ->

    it 'should be on time', (done)->
        customer = require('./index')()
        customer.waitfor 'food', (food)->
            done()
        .till 30, ->
            done new Error "should be served on time"

        delay 20, -> customer.deliver 'food', 'patato salad'

    it 'should be too late', (done)->
        customer = require('./index')()
        customer.waitfor 'food', (food)->
            done new Error "#{food} should not be served on time"
        .till 30, ->
            done()

        delay 40, -> customer.deliver 'food', 'patato spaghetti'

    it 'should be on time multi', (done)->
        customer = require('./index')()
        customer.waitfor ['food', 'drink'], (food, drink)->
            if food is 'patato spaghetti' and drink is 'soda water'
                done()
            else
                done new Error 'error'
        .till 50, (available)->
            done new Error 'should not be served on time'

        delay 20, -> customer.deliver 'food', 'patato spaghetti'
        delay 40, -> customer.deliver 'drink', 'soda water'

    it 'should be too late multi', (done)->
        customer = require('./index')()
        customer.waitfor ['food', 'drink'], (food, drink)->
            done new Error "#{food} and #{drink} should not be served"
        .till 50, (available)->
            if JSON.stringify(available) is '{"food":"patato spaghetti"}'
                done()
            else
                done JSON.stringify available

        delay 20, -> customer.deliver 'food', 'patato spaghetti'
        delay 70, -> customer.deliver 'drink', 'soda water'
