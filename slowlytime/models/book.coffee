db = require '../lib/mysql'

BookModel = 
    addCollection: (info,next) ->
        db.query 'INSERT INTO collection SET ?', info, (err, result)->
            next err, null if err
            next null, result
    getCollection: (info,next) ->
        db.query 'SELECT id,isbn FROM collection WHERE isbn = ?',[info.isbn],(err,result)->
            next err, null if err
            next null, result
    add: (info,next) ->
        db.query 'INSERT INTO books SET ?', info, (err, result) ->
            next err, null if err
            next null, result
            


module.exports = BookModel
