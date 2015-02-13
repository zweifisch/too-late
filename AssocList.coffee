class AssocList

    constructor:->
        @head = {}
        @tail = @head

    getItem: (key)->
        item = @head
        while item = item.next
            return item.val if item.key is key

    appendItem: (key, val)->
        @tail.next = key: key, val: val
        @tail = @tail.next

    swapItem: (key, fn)->
        item = @head
        while item = item.next
            if item.key is key
                item.val = fn item.val
                return yes
        no

    deleteItem: (key)->
        item = next: @head
        while item = item.next
            if nextItem = item.next
                if nextItem.key is key
                    item.next = nextItem.next
                    return nextItem.val

    iter: (fn)->
        item = @head
        while item = item.next
            break if fn item

    toArray: (fn)->
        ret = []
        item = @head
        while item = item.next
            ret.push [item.key, item.val]
        ret

module.exports = AssocList
