define (require,exports,module)->
    Router = require './lib/router'
    Register = require './user/register'
    Login = require './user/login'

    router = new Router()

    router.on 'reg',(err,current)->
        if current
            new Register()
    router.on 'login',(err,current)->
        if current
            new Login()
