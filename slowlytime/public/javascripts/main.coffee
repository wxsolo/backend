define (require,exports,module)->
    $ = require '$'
    bootstrap = require 'bootstrap'
    Router = require './lib/router'

    router = new Router()

    router.on 'reg',(err,current)->
        if current
            console.log current
    
