request = require 'request'

class Book
    constructor: (options) ->
       @options = options
    search: (next)->
        remoteUrl = 'https://api.douban.com/v2/book/search?q=' + decodeURIComponent(@options.title) + '&start=' + (@options.start || 0)
        request remoteUrl,(err,response,body)->
            if !err && response.statusCode == 200
                next null,JSON.parse body
            else
                next 'null',null
    detail: (next)->
        request 'https://api.douban.com/v2/book/isbn/' + @options.isbn,(err,response,body) ->
            if !err && response.statusCode == 200
                next null,JSON.parse body
            else
                next 'null',null

module.exports = Book
