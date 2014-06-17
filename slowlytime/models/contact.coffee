
db = require '../lib/mysql'

ContactModel = 
    
    add: (args,next) ->

        db.query 'INSERT INTO follow SET ?', args, (err, result) ->
            next err, null if err
            next null, result

module.exports = ContactModel
