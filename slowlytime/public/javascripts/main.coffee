define (require,exports,module)->
    Router = require './lib/router'
    Register = require './user/register'
    Login = require './user/login'
    Setting = require './user/setting'
    Main = require './book/main'
    scroll = require './scroll'
    $ = require '$'
    bootstrap = require 'bootstrap'
    #scroll()
    router = new Router()

    router.on 'reg',(err,current)->
        if current
            new Register()
    router.on 'login',(err,current)->
        if current
            new Login()
    router.on 'user',(err,current)->
        if current
            new Setting()
    router.on 'upload',(err,current)->
        if current
            new Main()
