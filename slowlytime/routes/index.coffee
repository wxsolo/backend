
#
# * GET home page.
# 

setting = require '../setting'
request = require 'request'
module.exports = (app) ->
    
    app.get '/',(req,res)->
        res.render 'index',
            title: setting.title
            brand: setting.brand
            user: req.session.user

    app.get '/login',(req,res)->
        res.render 'login',
            title: setting.title
            brand: setting.brand

    app.get '/reg',(req,res)->
        res.render 'reg',
            title: setting.title
            brand: setting.brand

