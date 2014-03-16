define (require,exports,module)->
    $ = require '$'
    Bootstrap = require 'bootstrap'
    Router = require './lib/router'
    Register = require './user/register'

    router = new Router()

    router.on 'reg',(err,current)->
        console.log current 
        if current
            new Register()
    
