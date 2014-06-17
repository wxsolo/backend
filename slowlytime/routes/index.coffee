
#
# * GET home page.
# 

setting = require '../setting'
request = require 'request'
User = require '../models/user'
module.exports = (app) ->
    
    app.get '/',(req,res) ->
        User.getHot (err,peoples) ->
            res.render 'index',
                title: setting.title
                brand: setting.brand
                user: req.session.user
                peoples: peoples

    app.get '/login',(req,res) ->
        res.render 'login',
            title: setting.title
            brand: setting.brand

    app.get '/reg',(req,res) ->
        res.render 'reg',
            title: setting.title
            brand: setting.brand
    app.get '/logout',(req,res) ->
        req.session.user = null
        res.redirect '/'

